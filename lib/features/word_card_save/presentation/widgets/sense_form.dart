import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';

import 'custom_text_field.dart';

const String SEPERATOR = ", ";

class SenseForm extends StatelessWidget {
  final WordCardDetails initSense;
  final Function(SenseForm) removeField;
  final List<CustomTextField> _children;

  SenseForm({
    Key key,
    @required this.removeField,
    this.initSense,
  })  : _children = [
          CustomTextField(
            labelText: 'Definition',
            helperText: 'Giving an instance of',
            initValue: initSense.definition,
          ),
          CustomTextField(
            labelText: 'Part of speech',
            helperText: 'Noun',
            initValue: initSense.partOfSpeech,
          ),
          CustomTextField(
            labelText: 'Examples',
            helperText: 'Giving an instance of',
            initValue: initSense.exampleList?.join(SEPERATOR),
          ),
          CustomTextField(
            labelText: 'Synonyms',
            helperText: 'Noun',
            initValue: initSense.synonymList?.join(SEPERATOR),
          ),
          CustomTextField(
            labelText: 'Antonyms',
            helperText: 'Giving an instance of',
            initValue: initSense.antonymList?.join(SEPERATOR),
          ),
        ],
        super(key: key);

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
    final String definition = _children[0].controller.text;
    final String partOfSpeech = _children[1].controller.text;
    final List<String> examples = _children[2].controller.text?.split(SEPERATOR);
    final List<String> synonyms = _children[3].controller.text?.split(SEPERATOR);
    final List<String> antonyms = _children[4].controller.text?.split(SEPERATOR);

    return WordCardDetails(
      definition: definition,
      partOfSpeech: partOfSpeech,
      exampleList: examples,
      synonymList: synonyms,
      antonymList: antonyms,
    );
  }
}
