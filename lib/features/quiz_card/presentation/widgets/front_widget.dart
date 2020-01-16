import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/ui/widgets/audio_player_widget.dart';
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
    _questionPortion(_children);
    _additionalInformation(_children);
    return _children;
  }

  void _additionalInformation(List<Widget> _children) {
    switch (quizCard.frontType) {
      case AttributeType.Pronunciation:
        _children.add(
          Center(child: AudioPlayerWidget(audioUrl: quizCard.front)),
        );
        break;
      case AttributeType.Example:
        _children.add(
          SubtitleText(text: "Examples of the word \"${quizCard.word}\""),
        );
        _makeOrderedList(_children, quizCard.front);
        break;
      case AttributeType.Definition:
        _children.add(
          SubtitleText(text: "Definition of the word \"${quizCard.word}\""),
        );
        _children.add(Text(quizCard.front));
        break;
      default:
    }
  }

  void _questionPortion(List<Widget> _children) {
    switch (quizCard.backType) {
      case AttributeType.Spelling:
        _children.add(_makeQuestion("Spell the word."));
        break;
      case AttributeType.Pronunciation:
        _children.add(_makeQuestion("Pronounce the word \"${quizCard.word}\""));
        break;
      case AttributeType.Syllables:
        _children.add(_makeQuestion(
          "Mention how many syllables the word \"${quizCard.word}\" has." +
              " And mention the syllables as well",
        ));
        break;
      case AttributeType.Example:
        _children.add(_makeQuestion(
          "Give some example uses of the word \"${quizCard.word}\".",
        ));
        break;
      case AttributeType.Definition:
        _children.add(_makeQuestion(
          "Define the meaning of the word \"${quizCard.word}\" in this context.",
        ));
        break;
      case AttributeType.Synonyms:
        _children.add(_makeQuestion(
          "Mention some synonyms of the word \"${quizCard.word}\"",
        ));
        break;
      case AttributeType.Antonyms:
        _children.add(_makeQuestion(
          "Mention some antonyms of the word \"${quizCard.word}\"",
        ));
        break;
      case AttributeType.PartOfSpeech:
        _children.add(_makeQuestion(
          "Mention the part of speech the word \"${quizCard.word}\" belongs to",
        ));
        break;
    }
  }

  Widget _makeQuestion(String question) => TitleText(text: question);

  void _makeOrderedList(List<Widget> _children, String data) {
    final List<String> pieces = data.split(' | ');
    for (int i = 1; i <= pieces.length; ++i)
      _children.add(Text("$i) ${pieces[i - 1]}"));
  }
}
