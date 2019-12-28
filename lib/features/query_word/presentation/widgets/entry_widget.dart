import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/entry.dart';

import 'sense_widget.dart';

class EntryWidget extends StatelessWidget {
  final int index;
  final Entry entry;

  const EntryWidget({
    Key key,
    @required this.entry,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Theme.of(context).textTheme.title;
    final TextStyle subtitleStyle = Theme.of(context).textTheme.subtitle;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text('Entry #$index', style: titleStyle),
          ),
          Text('Etymology(s)', style: subtitleStyle),
          Column(children: List.from(entry.etymologyList.map(_toText))),
          Text('Note(s)', style: subtitleStyle),
          Column(
            children: List.from(entry.noteList.map((e) => _toText(e.text))),
          ),
          Column(
            children: List<Widget>.generate(
              entry.senseList.length,
              _generateSenseWidget,
            ),
          ),
        ],
      ),
    );
  }

  Text _toText(String e) => Text(e);

  Widget _generateSenseWidget(int index) => SenseWidget(
        sense: entry.senseList[index],
        index: index + 1,
      );
}
