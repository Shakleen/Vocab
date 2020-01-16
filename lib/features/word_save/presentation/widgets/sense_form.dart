import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';
import 'package:vocab/core/ui/widgets/subtitle_text.dart';

import 'custom_text_field.dart';

const String SEPERATOR = " | ";

class SenseForm extends StatelessWidget {
  final WordCardDetails initSense;
  final Function(SenseForm) removeField;
  List<Widget> _children;
  final List<String> _posNames = const [
    'Noun',
    'Pronoun',
    'Verb',
    'Adjective',
    'Adverb',
    'Preposition',
    'Conjunction',
    'Interjection',
  ];
  int _partOfSpeech;

  SenseForm({Key key, @required this.removeField, this.initSense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_partOfSpeech == null) {
      if (initSense != null) {
        _partOfSpeech = PART_OF_SPEECH_TYPE_TO_ID[initSense.partOfSpeech];
      } else {
        _partOfSpeech = 1;
      }
    }

    _children = [
      CustomTextField(
        labelText: 'Definition',
        initValue: initSense?.definition,
      ),
      SubtitleText(text: 'Part of speech'),
      DropdownButton<int>(
        items: List<DropdownMenuItem<int>>.generate(
          _posNames.length,
          (int index) => DropdownMenuItem(
            child: Text(_posNames[index]),
            value: index + 1,
          ),
        ),
        onChanged: (int value) => _partOfSpeech = value,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        value: _partOfSpeech,
        isExpanded: true,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
      CustomTextField(
        labelText: 'Examples',
        initValue: initSense?.exampleList?.join(SEPERATOR),
        isNullable: true,
      ),
      CustomTextField(
        labelText: 'Synonyms',
        initValue: initSense?.synonymList?.join(SEPERATOR),
        isNullable: true,
      ),
      CustomTextField(
        labelText: 'Antonyms',
        initValue: initSense?.antonymList?.join(SEPERATOR),
        isNullable: true,
      ),
    ];
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _children,
              ),
            )
          ],
        ),
      ),
    );
  }

  WordCardDetails getSenseFormValues() {
    final List values = [];

    for (final Widget widget in _children)
      if (widget is CustomTextField)
        values.add(widget.controller.text?.split(SEPERATOR));

    return WordCardDetails(
      id: initSense?.id,
      definition: values[0].join(''),
      partOfSpeech: ID_TO_PART_OF_SPEECH_TYPE[_partOfSpeech],
      exampleList: values[1],
      synonymList: values[2],
      antonymList: values[3],
    );
  }
}
