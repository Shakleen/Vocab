import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/features/word_card_save/presentation/widgets/custom_text_field.dart';
import 'package:vocab/features/word_card_save/presentation/widgets/form_values_inherited_widget.dart';
import 'package:vocab/features/word_card_save/presentation/widgets/sense_form_list.dart';

class CardFormPage extends StatefulWidget {
  final WordCard initialWordCard;

  CardFormPage({Key key, this.initialWordCard}) : super(key: key);

  @override
  _CardFormPageState createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, dynamic> _formValues = {
    'word': '',
    'pronunciation': '',
    'syllables': '',
    'details': [],
  };
  CustomTextField wordField, pronunciationField, syllablesField;

  @override
  void initState() {
    super.initState();
    wordField = CustomTextField(
      labelText: 'Word',
      helperText: 'e.g. example',
    );
    pronunciationField = CustomTextField(
      labelText: 'Pronunciation',
      helperText: 'Audio file link',
    );
    syllablesField = CustomTextField(
      labelText: 'Syllables',
      helperText: 'e.g. ex-am-ple',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _submit,
          )
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
            )),
            wordField,
            pronunciationField,
            syllablesField,
            SenseFormList(),
          ],
        ),
      ),
    );
  }

  void _submit() {
    // if (!_formKey.currentState.validate()) return;
    final String word = wordField.controller.value.text;
    final String pronunciation = pronunciationField.controller.value.text;
    final List<String> syllables = syllablesField.controller.value.text.split('-');

    print(word);
    print(pronunciation);
    print(syllables);
  }
}
