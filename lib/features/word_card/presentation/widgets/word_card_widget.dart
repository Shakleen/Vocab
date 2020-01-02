import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/features/word_card/domain/entities/word_card_details.dart';

import 'title_and_word_list.dart';

class WordCardWidget extends StatelessWidget {
  final List<Widget> children = [];
  final WordCardDetails wordCardDetails;
  final int index;

  WordCardWidget({
    Key key,
    @required this.index,
    @required this.wordCardDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    children.addAll([
      TitleText(text: 'Definition(s)'),
      Text(wordCardDetails.definition),
    ]);

    _checkAndCreate('Example(s)', wordCardDetails.exampleList);
    _checkAndCreate('Synonym(s)', wordCardDetails.synonymList);
    _checkAndCreate('Antonym(s)', wordCardDetails.antonymList);

    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  void _checkAndCreate(String title, List<String> list) {
    if (list != null) if (list.isNotEmpty)
      children.add(TitleAndWordList(title: title, wordList: list));
  }
}