import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/features/word_card/domain/entities/word_card.dart';
import 'package:vocab/features/word_card/domain/entities/word_card_details.dart';

class LoadedStateUI extends StatelessWidget {
  final WordCard wordCard;

  const LoadedStateUI({Key key, @required this.wordCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(child: DisplayWordText(text: wordCard.word)),
        SizedBox(height: 16),
        HeadlineText(
          text: 'Pronunciation: ${wordCard.pronunciation.all}',
        ),
        SizedBox(height: 16),
        HeadlineText(
          text: 'Syllables(${wordCard.syllables.count}):' +
              ' ${wordCard.syllables.list}',
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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

class WordCardWidget extends StatelessWidget {
  final WordCardDetails wordCardDetails;
  final int index;

  const WordCardWidget({
    Key key,
    @required this.index,
    @required this.wordCardDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      TitleText(text: 'Definition(s)'),
      Text(wordCardDetails.definition),
    ];

    if (wordCardDetails.exampleList != null) {
      if (wordCardDetails.exampleList.isNotEmpty) {
        children.addAll([
          TitleText(text: 'Example(s)'),
          Column(
            children: List<Text>.from(
              wordCardDetails.exampleList.map(
                (String example) => Text(example),
              ),
            ),
          ),
        ]);
      }
    }

    if (wordCardDetails.synonymList != null) {
      if (wordCardDetails.synonymList.isNotEmpty) {
        children.addAll([
          TitleText(text: 'Synonym(s)'),
          // GridView(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //   ),
          //   children: List<Widget>.from(wordCardDetails.synonymList.map(
          //     (String synonym) => Text(synonym),
          //   )),
          // ),
        ]);
      }
    }

    if (wordCardDetails.antonymList != null) {
      if (wordCardDetails.antonymList.isNotEmpty) {
        children.addAll([
          TitleText(text: 'Antonym(s)'),
        ]);
      }
    }

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}
