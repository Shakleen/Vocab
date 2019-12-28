import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/related_entry.dart';

import 'title_text.dart';

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