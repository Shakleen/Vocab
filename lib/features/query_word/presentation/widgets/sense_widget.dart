import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/sense.dart';

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
    final TextStyle subtitleStyle = Theme.of(context).textTheme.subtitle;
    final String text = isSubsense ? "Subsense" : "Sense";
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('$text #$index', style: subtitleStyle),
          Text('Definition(s)', style: subtitleStyle),
          Column(children: List.from(sense.definitionList.map(_toText))),
          Text('Short definition(s)', style: subtitleStyle),
          Column(children: List.from(sense.shortDefinitions.map(_toText))),
          Text('Example(s)', style: subtitleStyle),
          Column(
              children:
                  List.from(sense.exampleList.map((e) => _toText(e.text)))),
          Text('Subsense(s)', style: subtitleStyle),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(
              sense.subsenseList.length,
              _generateSenseWidget,
            ),
          ),
        ],
      ),
    );
  }

  _toText(String e) => Text(e);

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
