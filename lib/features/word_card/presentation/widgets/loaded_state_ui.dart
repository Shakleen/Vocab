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

class TitleAndWordList extends StatelessWidget {
  final String title;
  final List<String> wordList;

  const TitleAndWordList({
    Key key,
    @required this.title,
    @required this.wordList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [TitleText(text: title)];
    children.addAll(
      List<Widget>.generate(
        wordList.length,
        (int index) => Text('${index+1}. ${wordList[index]}'),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
    );
  }
}
