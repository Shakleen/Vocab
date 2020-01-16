import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/ui/widgets/audio_player_widget.dart';
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
      case AttributeType.Spelling:
        _children.add(Text(quizCard.back));
        break;
      case AttributeType.Pronunciation:
        _children.add(
          Center(child: AudioPlayerWidget(audioUrl: quizCard.back)),
        );
        break;
      case AttributeType.Syllables:
        _children.add(TitleText(text: "Syllables of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case AttributeType.Example:
        _children.add(TitleText(text: "Examples of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case AttributeType.Definition:
        _children.add(TitleText(text: "Definition of \"${quizCard.word}\""));
        _children.add(Text(quizCard.back));
        break;
      case AttributeType.Synonyms:
        _children.add(TitleText(text: "Synonyms of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case AttributeType.Antonyms:
        _children.add(TitleText(text: "Antonyms of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case AttributeType.PartOfSpeech:
        _children
            .add(TitleText(text: "Part of Speech of \"${quizCard.word}\""));
        _children.add(Text(quizCard.back));
    }

    return _children;
  }

  void _makeOrderedList(List<Widget> _children) {
    final List<String> pieces = quizCard.back.split(' | ');
    for (int i = 1; i <= pieces.length; ++i)
      _children.add(Text("$i) ${pieces[i - 1]}"));
  }
}
