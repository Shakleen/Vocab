import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';
import 'package:vocab/core/ui/widgets/word_card_widget.dart';

class WordInfoWidget extends StatelessWidget {
  final WordCard wordCard;

  const WordInfoWidget({Key key, @required this.wordCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        Center(child: DisplayWordText(text: wordCard.word)),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: HeadlineText(
            text: 'Pronunciation: ${wordCard.pronunciation.all}',
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: HeadlineText(
            text: 'Syllables(${wordCard.syllables.count}):' +
                ' ${wordCard.syllables.list}',
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            wordCard.detailList.length,
            _generateWordCardWidget,
          ),
        ),
      ],
    );
  }

  Widget _generateWordCardWidget(int index) {
    return WordCardWidget(
      wordCardDetails: wordCard.detailList[index],
      index: index + 1,
    );
  }
}
