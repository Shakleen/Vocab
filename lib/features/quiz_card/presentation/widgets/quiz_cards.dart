import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';

class QuizCards extends StatefulWidget {
  final List<QuizCard> quizCards;

  QuizCards({Key key, @required this.quizCards}) : super(key: key);

  @override
  _QuizCardsState createState() => _QuizCardsState();
}

class _QuizCardsState extends State<QuizCards> {
  int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FrontWidget(quizCard: widget.quizCards[_index]),
          ),
          Expanded(
            flex: 5,
            child: BackWidget(),
          )
          Expanded(
            flex: 1,
            child: Controls(),
          )
        ],
      ),
    );
  }
}

class FrontWidget extends StatelessWidget {
  final QuizCard quizCard;

  FrontWidget({Key key, @required this.quizCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> _children = [];

    switch(quizCard.frontType) {
      case 1: 
        _children.add(TitleText(text: "Spelling"));
        break;
      case 2:
        _children.add(TitleText(text: "Pronunciation"));
        break;
      case 3:
        _children.add(TitleText(text: "Definition"));
        break;
      case 4:
        _children.add(TitleText(text: "Examples"));
        final List<String> pieces = quizCard.front.split(' | ');
        for (int i = 1; i <= pieces.length; ++i) 
          _children.add(Text("$i) ${pieces[i-1]}"));
        break;
    }

    return _children;
  }
}

/*

    String frontText, title;

    if (quizCard.frontType == 3) title = "Syllables";
    else if (quizCard.frontType == 4) title = "Examples";
    else if (quizCard.frontType == 6) title = "Synonyms";
    else if (quizCard.frontType == 7) title = "Antonyms";


    switch(quizCard.frontType) {
      case 3:
      case 4:
      case 5:
        final List<String> pieces = quizCard.front.split(' | ');
        frontText = "$title:\n";
        for (int i = 1; i <= pieces.length; ++i) 
          frontText += "$i) ${pieces[i-1]}\n";
        break;

    }
*/