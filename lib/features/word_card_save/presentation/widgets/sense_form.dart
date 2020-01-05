import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';

import 'custom_text_field.dart';
import 'increasing_text_fields.dart';

class SenseForm extends StatelessWidget {
  final Function(SenseForm) removeField;
  final List<Widget> _children = [
    CustomTextField(
      labelText: 'Definition',
      helperText: 'Giving an instance of',
    ),
    CustomTextField(
      labelText: 'Part of speech',
      helperText: 'Noun',
    ),
    IncreasingTextFields(title: 'Example'),
    IncreasingTextFields(title: 'Synonym'),
    IncreasingTextFields(title: 'Antonym'),
  ];

  SenseForm({Key key, @required this.removeField}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  HeadlineText(text: 'Sense'),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => removeField(this),
                    color: Theme.of(context).errorColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(children: _children),
            )
          ],
        ),
      ),
    );
  }

  WordCardDetails getSenseFormValues() {
    String definition, partOfSpeech;
    List<String> examples, synonyms, antonyms;

    final defField = _children[0];
    if (defField is CustomTextField) definition = defField.controller.text;

    final posField = _children[1];
    if (posField is CustomTextField) partOfSpeech = posField.controller.text;

    final examplesField = _children[2];
    if (examplesField is IncreasingTextFields)
      examples = examplesField.getFormTextStrings();

    final synonymsField = _children[3];
    if (synonymsField is IncreasingTextFields)
      synonyms = synonymsField.getFormTextStrings();

    final antonymsField = _children[4];
    if (antonymsField is IncreasingTextFields)
      antonyms = antonymsField.getFormTextStrings();

    return WordCardDetails(
      definition: definition,
      partOfSpeech: partOfSpeech,
      exampleList: examples,
      synonymList: synonyms,
      antonymList: antonyms,
    );
  }
}
