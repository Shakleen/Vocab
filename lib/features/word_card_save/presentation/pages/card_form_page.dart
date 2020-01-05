import 'package:flutter/material.dart';
import 'package:vocab/core/entities/pronunciation.dart';
import 'package:vocab/core/entities/syllable.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/features/word_card_save/presentation/widgets/custom_text_field.dart';
import 'package:vocab/features/word_card_save/presentation/widgets/increasing_text_fields.dart';
import 'package:vocab/features/word_card_save/presentation/widgets/sense_form_list.dart';

class CardFormPage extends StatefulWidget {
  final WordCard initialWordCard;

  CardFormPage({Key key, this.initialWordCard}) : super(key: key);

  @override
  _CardFormPageState createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  CustomTextField wordField, pronunciationField;
  IncreasingTextFields syllablesField;
  SenseFormList senseFormList;

  @override
  void initState() {
    super.initState();
    wordField = CustomTextField(labelText: 'Word', helperText: 'e.g. example');
    pronunciationField = CustomTextField(
      labelText: 'Pronunciation',
      helperText: 'Audio file link',
    );
    syllablesField = IncreasingTextFields(title: 'Syllable');
    senseFormList = SenseFormList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.done), onPressed: _submit)
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Center(
              child: DisplayWordText(
                text: widget.initialWordCard == null
                    ? 'Add new'
                    : 'Edit existing',
              ),
            ),
            wordField,
            pronunciationField,
            syllablesField,
            senseFormList,
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState.validate()) return;
    final String word = wordField.controller.value.text;
    final String pronunciation = pronunciationField.controller.value.text;
    final List<String> syllables = syllablesField.getFormTextStrings();
    final List<WordCardDetails> details = senseFormList.getSenseValues();

    print(word);
    print(pronunciation);
    print(syllables);

    details.forEach((WordCardDetails details) {
      print('Definition: ${details.definition}');
      print('POS: ${details.partOfSpeech}');

      print('Examples');
      details.exampleList.forEach((String e) => print(e));
      print('Synonyms');
      details.synonymList.forEach((String e) => print(e));
      print('Antonyms');
      details.antonymList.forEach((String e) => print(e));

      print('\n\n');
    });

    final WordCard wordCard = WordCard(
      word: word,
      pronunciation: Pronunciation(all: pronunciation),
      syllables: Syllable(count: syllables.length, list: syllables),
      detailList: details,
    );
  }
}
