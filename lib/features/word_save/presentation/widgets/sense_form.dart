import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';
import 'package:vocab/core/ui/widgets/subtitle_text.dart';
import 'package:vocab/core/enums/part_of_speech.dart';

import 'custom_text_field.dart';
import 'part_of_speech_dropdown.dart';

const String SEPERATOR = " | ";

class SenseForm extends StatelessWidget {
  final WordCardDetails initSense;
  final Function(SenseForm) removeField;
  List<Widget> _children;

  SenseForm({Key key, @required this.removeField, this.initSense})
      : _children = [
          CustomTextField(
            labelText: 'Definition',
            initValue: initSense?.definition,
          ),
          SubtitleText(text: 'Part of speech'),
          PartOfSpeechDropDown(partOfSpeech: initSense?.partOfSpeech),
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
    int partOfSpeech;

    for (final Widget widget in _children)
      if (widget is CustomTextField)
        values.add(widget.controller.text?.split(SEPERATOR));
      else if (widget is PartOfSpeechDropDown)
        partOfSpeech = widget.choice;

    return WordCardDetails(
      id: initSense?.id,
      definition: values[0].join(''),
      partOfSpeech: ID_TO_PART_OF_SPEECH_TYPE[partOfSpeech],
      exampleList: values[1],
      synonymList: values[2],
      antonymList: values[3],
    );
  }
}
