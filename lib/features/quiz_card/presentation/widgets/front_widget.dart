import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/subtitle_text.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';

class FrontWidget extends StatelessWidget {
  final QuizCard quizCard;

  FrontWidget({Key key, @required this.quizCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> _children = [];

    switch (quizCard.frontType) {
      case 1:
        _children.add(TitleText(text: "Spelling"));
        _children.add(Text(quizCard.front));
        break;
      case 2:
        _children.add(TitleText(text: "Pronunciation"));
        _children.add(Text(quizCard.front));
        break;
      case 4:
        _children.add(TitleText(text: "Examples"));
        _makeOrderedList(_children, quizCard.front);
        break;
      case 5:
        _children.add(TitleText(text: "Definition"));
        _children.add(Text(quizCard.front));
        break;
    }

    switch (quizCard.backType) {
      case 1:
        _children.add(
          _makeQuestion("Spell the word \"${quizCard.word}\"."),
        );
        break;
      case 2:
        _children.add(
          _makeQuestion("Pronounce the word \"${quizCard.word}\""),
        );
        break;
      case 3:
        _children.add(
          _makeQuestion(
            "Mention how many syllables the word \"${quizCard.word}\" has." +
                " And mention the syllables as well",
          ),
        );
        break;
      case 4:
        _children.add(
          _makeQuestion(
              "Give some example uses of the word \"${quizCard.word}\"."),
        );
        break;
      case 5:
        _children.add(
          _makeQuestion(
            "Define the meaning of the word \"${quizCard.word}\" in this context.",
          ),
        );
        break;
      case 6:
        _children.add(
          _makeQuestion(
              "Mention some synonyms of the word \"${quizCard.word}\""),
        );
        break;
      case 7:
        _children.add(
          _makeQuestion(
              "Mention some antonyms of the word \"${quizCard.word}\""),
        );
        break;
      case 8:
        _children.add(
          _makeQuestion(
              "Mention the part of speech the word \"${quizCard.word}\" belongs to"),
        );
        break;
    }

    return _children;
  }

  Widget _makeQuestion(String question) => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SubtitleText(text: question),
      );

  void _makeOrderedList(List<Widget> _children, String data) {
    final List<String> pieces = data.split(' | ');
    for (int i = 1; i <= pieces.length; ++i)
      _children.add(Text("$i) ${pieces[i - 1]}"));
  }
}