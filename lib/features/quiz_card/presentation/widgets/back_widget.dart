
import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';

class BackWidget extends StatelessWidget {
  final QuizCard quizCard;

  BackWidget({Key key, @required this.quizCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> _children = [];

    switch (quizCard.backType) {
      case 1:
        _children.add(TitleText(text: "Spelling"));
        _children.add(Text(quizCard.back));
        break;
      case 2:
        _children.add(TitleText(text: "Pronunciation"));
        _children.add(Text(quizCard.back));
        break;
      case 3:
        _children.add(TitleText(text: "Syllables of \"${quizCard.word}\""));
        _children.add(Text(quizCard.back));
        break;
      case 4:
        _children.add(TitleText(text: "Examples of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case 5:
        _children.add(TitleText(text: "Definition of \"${quizCard.word}\""));
        _children.add(Text(quizCard.back));
        break;
      case 6:
        _children.add(TitleText(text: "Synonyms of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case 7:
        _children.add(TitleText(text: "Antonyms of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case 8:
        _children
            .add(TitleText(text: "Part of Speech of \"${quizCard.word}\""));
        _children.add(Text(quizCard.back));
        break;
    }

    return _children;
  }

  void _makeOrderedList(List<Widget> _children) {
    final List<String> pieces = quizCard.back.split(' | ');
    for (int i = 1; i <= pieces.length; ++i)
      _children.add(Text("$i) ${pieces[i - 1]}"));
  }
}

