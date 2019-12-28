import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/entry.dart';
import 'package:vocab/features/query_word/presentation/widgets/subtitle_text.dart';
import 'package:vocab/features/query_word/presentation/widgets/title_text.dart';

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
    final List<Widget> children = [
      Center(child: TitleText(text: 'Entry #$index')),
    ];

    if (entry.etymologyList.isNotEmpty) {
      children.addAll([
        SubtitleText(text: 'Etymology(s)'),
        Column(children: List.from(entry.etymologyList.map(_toText))),
      ]);
    }

    if (entry.noteList.isNotEmpty) {
      children.addAll([
        SubtitleText(text: 'Note(s)'),
        Column(children: List.from(entry.noteList.map((e) => _toText(e.text)))),
      ]);
    }

    children.add(Column(
      children: List<Widget>.generate(
        entry.senseList.length,
        _generateSenseWidget,
      ),
    ));

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Text _toText(String e) => Text(e);

  Widget _generateSenseWidget(int index) => SenseWidget(
        sense: entry.senseList[index],
        index: index + 1,
      );
}
