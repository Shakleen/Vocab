import 'package:flutter/material.dart';
import 'package:vocab/core/entities/pronunciation.dart';
import 'package:vocab/core/entities/syllable.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/core/database/card_database.dart' as db;
import 'package:vocab/features/word_save/presentation/widgets/custom_text_field.dart';
import 'package:vocab/features/word_save/presentation/widgets/sense_form_list.dart';
import 'package:vocab/injection_container.dart';

const String SEPERATOR = " | ";

class CardFormPage extends StatefulWidget {
  final WordCard initialWordCard;
  final bool isEditing;

  CardFormPage({
    Key key,
    this.initialWordCard,
    this.isEditing = false,
  }) : super(key: key);

  @override
  _CardFormPageState createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  CustomTextField wordField, pronunciationField, syllablesField;
  SenseFormList senseFormList;
  db.WordDao _wordDao;

  @override
  void initState() {
    super.initState();
    db.CardDatabase cardDatabase = sl();
    _wordDao = cardDatabase.wordDao;
    wordField = CustomTextField(
      initValue: widget.initialWordCard?.word,
      labelText: 'Word',
    );
    pronunciationField = CustomTextField(
      initValue: widget.initialWordCard?.pronunciation?.all,
      labelText: 'Pronunciation',
    );
    syllablesField = CustomTextField(
      initValue: widget.initialWordCard?.syllables?.list?.join(SEPERATOR),
      labelText: "Syllables",
    );
    senseFormList = SenseFormList(
      initSenses: widget.initialWordCard?.detailList,
    );
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
                text: widget.isEditing ? 'Edit existing' : 'Add new',
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

  void _submit() async {
    if (!_formKey.currentState.validate()) return;
    final String word = wordField.controller.value.text;
    final String pronunciation = pronunciationField.controller.value.text;
    final List<String> syllables =
        syllablesField.controller.value.text?.split(SEPERATOR);
    final List<WordCardDetails> details = senseFormList.getSenseValues();

    final WordCard wordCard = WordCard(
      id: widget.initialWordCard?.id,
      word: word,
      pronunciation: Pronunciation(all: pronunciation),
      syllables: Syllable(count: syllables.length, list: syllables),
      detailList: details,
    );

    bool result;

    if (widget.isEditing) {
      result = await _wordDao.updateWordCard(wordCard);
      print('Update result: $result');
    } else {
      result = await _wordDao.insertWordCard(wordCard);
      print('Insertion result: $result');
    }

    if (result) {
      db.CardDatabase cardDatabase = sl();
      db.CardDao cardDao = cardDatabase.cardDao;
      await cardDao.createNewQuizCards(wordCard);
      Navigator.pop(context);
    }
  }
}
