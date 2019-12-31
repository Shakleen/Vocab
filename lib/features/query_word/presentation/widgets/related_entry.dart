import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/related_entry.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TitleText(text: title),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.from(
            relatedEntryList.map((e) => Text(e.text)),
          ),
        ),
      ],
    );
  }
}
