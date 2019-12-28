import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/sense.dart';

import 'subtitle_text.dart';

class SenseWidget extends StatelessWidget {
  final Sense sense;
  final int index;
  final bool isSubsense;

  const SenseWidget({
    Key key,
    @required this.sense,
    @required this.index,
    this.isSubsense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String text = isSubsense ? "Subsense" : "Sense";
    final List<Widget> children = [
      SubtitleText(text: '$text #$index'),
      SubtitleText(text: 'Definition(s)'),
      Column(children: List.from(sense.definitionList.map(_toText))),
      SubtitleText(text: 'Short definition(s)'),
      Column(children: List.from(sense.shortDefinitions.map(_toText))),
      SubtitleText(text: 'Example(s)'),
      Column(
        children: List.from(sense.exampleList.map((e) => _toText(e.text))),
      ),
    ];

    if (sense.subsenseList.isNotEmpty)
      children.addAll([
        SubtitleText(text: 'Subsense(s)'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List<Widget>.generate(
            sense.subsenseList.length,
            _generateSenseWidget,
          ),
        ),
      ]);

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Text _toText(String e) => Text(e);

  Widget _generateSenseWidget(int i) => Card(
        elevation: 2,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          child: SenseWidget(
            sense: sense.subsenseList[i],
            index: i + 1,
            isSubsense: true,
          ),
        ),
      );
}
