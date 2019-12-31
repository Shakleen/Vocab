import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/lexical_entry.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';

import 'entry_widget.dart';
import 'pronunciation_widget.dart';
import 'related_entry.dart';

class LexicalEntryWidget extends StatelessWidget {
  final LexicalEntry lexicalEntry;
  final int index;

  const LexicalEntryWidget({
    Key key,
    @required this.lexicalEntry,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Center(child: HeadlineText(text: 'Lexical Entry #$index')),
      TitleText(
        text: 'Lexical Category: ${lexicalEntry.lexicalCategory.text}',
      ),
    ];

    if (lexicalEntry.derivativeList.isNotEmpty)
      children.add(
        RelatedEntryWidget(
          relatedEntryList: lexicalEntry.derivativeList,
          title: "Derivative",
        ),
      );

    if (lexicalEntry.derivativeOfList.isNotEmpty)
      children.add(
        RelatedEntryWidget(
          relatedEntryList: lexicalEntry.derivativeOfList,
          title: "Derivative Of",
        ),
      );

    if (lexicalEntry.pronunciationList.isNotEmpty)
      children.add(
        Column(
          children: List<Widget>.generate(
            lexicalEntry.pronunciationList.length,
            _generatePronunciationWidget,
          ),
        ),
      );

    if (lexicalEntry.entryList.isNotEmpty)
      children.add(
        Column(
          children: List<Widget>.generate(
            lexicalEntry.entryList.length,
            _generateEntryWidget,
          ),
        ),
      );

    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _generatePronunciationWidget(int index) => PronunciationWidget(
        index: index + 1,
        pronunciation: lexicalEntry.pronunciationList[index],
      );

  Widget _generateEntryWidget(int index) => EntryWidget(
        entry: lexicalEntry.entryList[index],
        index: index + 1,
      );
}


