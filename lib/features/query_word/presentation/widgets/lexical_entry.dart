import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/lexical_entry.dart';
import 'package:vocab/features/query_word/domain/entities/related_entry.dart';

import 'entry_widget.dart';
import 'headline_text.dart';
import 'pronunciation_widget.dart';
import 'title_text.dart';

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
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeadlineText(text: 'Lexical Entry #$index'),
            TitleText(
              text: 'Lexical Category: ${lexicalEntry.lexicalCategory.text}',
            ),
            _createWidgetIfExists(lexicalEntry.derivativeList, "Derivative"),
            _createWidgetIfExists(
              lexicalEntry.derivativeOfList,
              "Derivative of",
            ),
            SizedBox(height: 10),
            Column(
              children: List<Widget>.generate(
                lexicalEntry.pronunciationList.length,
                _generatePronunciationWidget,
              ),
            ),
            Column(
              children: List<Widget>.generate(
                lexicalEntry.entryList.length,
                _generateEntryWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _createWidgetIfExists(data, title) {
    if (data.length > 0) return RelatedEntryWidget(relatedEntryList: data, title: title);
    return Container();
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

class RelatedEntryWidget extends StatelessWidget {
  final List<RelatedEntry> relatedEntryList;
  final String title;

  const RelatedEntryWidget({
    Key key,
    @required this.relatedEntryList,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TitleText(text: title),
        Column(
          children: List.from(
            relatedEntryList.map((e) => Text(e.text)),
          ),
        ),
      ],
    );
  }
}
