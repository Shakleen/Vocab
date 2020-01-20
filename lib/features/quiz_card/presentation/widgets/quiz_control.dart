import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:provider/provider.dart';

class QuizControls extends StatefulWidget {
  final Function next;
  final Function reveal;
  final QuizCard quizCard;

  QuizControls({
    Key key,
    @required this.next,
    @required this.reveal,
    @required this.quizCard,
  }) : super(key: key);

  @override
  _QuizControlsState createState() => _QuizControlsState();
}

class _QuizControlsState extends State<QuizControls> {
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: _getChild(),
    );
  }

  Widget _getChild() {
    if (_revealed) {
      return ButtonBar(
        buttonMinWidth: 100,
        buttonHeight: 65,
        alignment: MainAxisAlignment.spaceAround,
        buttonTextTheme: ButtonTextTheme.primary,
        children: <Widget>[
          RaisedButton(
            child: Text(
              "Again\n(1 min)",
              textAlign: TextAlign.center,
            ),
            color: Colors.red,
            onPressed: _handleAgain,
          ),
          RaisedButton(
            child: Text(
              "Good\n${_getTime()}",
              textAlign: TextAlign.center,
            ),
            color: Colors.green,
            onPressed: _handleGood,
          ),
        ],
      );
    } else {
      return RaisedButton(
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text("Reveal"),
        ),
        textTheme: ButtonTextTheme.primary,
        color: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            widget.reveal();
            _revealed = true;
          });
        },
      );
    }
  }

  String _getTime() {
    final int level = widget.quizCard.level;

    if (level == 0) {
      return "10 minutes";
    } else if (level == 1) {
      return "1 day";
    } else if (level < 15) {
      return "${2 * level - 1} days";
    } else {
      final double time = (level / 15);
      return "${time.toStringAsFixed(1)} months";
    }
  }

  void _handleAgain() async {
    await Provider.of<CardDatabase>(context, listen: false)
        .quizCardDao
        .updateCardLevel(
            widget.quizCard.id, 0, DateTime.now().add(Duration(minutes: 1)));
    widget.next();
  }

  void _handleGood() async {
    final int level = widget.quizCard.level;
    await Provider.of<CardDatabase>(context, listen: false)
        .quizCardDao
        .updateCardLevel(
          widget.quizCard.id,
          level + 1,
          DateTime.now().add(
            level < 1
                ? Duration(minutes: 10)
                : Duration(days: (level + 1) * 2 - 1),
          ),
        );
    widget.next();
  }
}
