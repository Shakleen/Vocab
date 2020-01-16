import 'package:flutter/material.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/back_widget.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/front_widget.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/quiz_control.dart';

class QuizCards extends StatefulWidget {
  final List<QuizCard> quizCards;

  QuizCards({Key key, @required this.quizCards}) : super(key: key);

  @override
  _QuizCardsState createState() => _QuizCardsState();
}

class _QuizCardsState extends State<QuizCards> {
  int _index;
  QuizControls _controls;
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _buildChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _children,
    );
  }

  void _revealAnswer() {
    setState(() {
      _children = <Widget>[
        FrontWidget(quizCard: widget.quizCards[_index]),
        Divider(color: Colors.grey, height: 2, thickness: 2),
        Expanded(child: BackWidget(quizCard: widget.quizCards[_index])),
        _controls,
      ];
    });
  }

  void _nextCard() {
    _index += 1;
    if (_index < widget.quizCards.length) {
      setState(() {
        _buildChildren();
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _buildChildren() {
    _controls = QuizControls(
      key: ValueKey(_index),
      next: _nextCard,
      reveal: _revealAnswer,
      quizCard: widget.quizCards[_index],
    );
    _children = <Widget>[
      Expanded(
        flex: 1,
        child: FrontWidget(quizCard: widget.quizCards[_index]),
      ),
      _controls,
    ];
  }
}
