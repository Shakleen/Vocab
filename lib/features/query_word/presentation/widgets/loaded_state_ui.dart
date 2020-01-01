import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

import 'headword_widget.dart';

class LoadedStateUI extends StatelessWidget {
  final RetrieveEntry retrieveEntry;

  const LoadedStateUI({Key key, @required this.retrieveEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        DisplayWordText(text: retrieveEntry.word),
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
