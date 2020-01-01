import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/headword_entry.dart';

import 'lexical_entry.dart';

class HeadwordWidget extends StatelessWidget {
  final HeadwordEntry headwordEntry;
  final int index;

  const HeadwordWidget({
    Key key,
    @required this.headwordEntry,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(
          headwordEntry.lexicalEntryList.length,
          _generate,
        ),
      ),
    );
  }

  Widget _generate(int index) => LexicalEntryWidget(
        lexicalEntry: headwordEntry.lexicalEntryList[index],
        index: index + 1,
      );
}
