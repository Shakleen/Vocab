import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

import 'headword_widget.dart';

class LoadedStateUI extends StatelessWidget {
  final RetrieveEntry retrieveEntry;

  const LoadedStateUI({Key key, @required this.retrieveEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle headlineStyle =
        Theme.of(context).textTheme.display2.copyWith(
              color: Theme.of(context).primaryColor,
            );
    return ListView(
      children: <Widget>[
        Text(
          '"${retrieveEntry.word}"',
          style: headlineStyle,
          textAlign: TextAlign.center,
        ),
        Column(
          children: List<Widget>.generate(
            retrieveEntry.resultList.length,
            _generateHeadwordWidget,
          ),
        ),
      ],
    );
  }

  Widget _generateHeadwordWidget(int index) => HeadwordWidget(
        headwordEntry: retrieveEntry.resultList[index],
        index: index + 1,
      );
}
