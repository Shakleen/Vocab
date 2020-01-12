import 'package:flutter/material.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:vocab/core/database/card_database.dart' as db;

import '../../../../injection_container.dart';

class ToggleImportanceButton extends StatefulWidget {
  final QuizCard quizCard;

  ToggleImportanceButton({Key key, @required this.quizCard}) : super(key: key);

  @override
  _ToggleImportanceButtonState createState() => _ToggleImportanceButtonState();
}

class _ToggleImportanceButtonState extends State<ToggleImportanceButton> {
  db.CardDao cardDao;
  bool _status;

  @override
  void initState() {
    super.initState();
    db.CardDatabase cardDatabase = sl();
    cardDao = cardDatabase.cardDao;
    _status = widget.quizCard.isImportant;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(_status ? Icons.favorite : Icons.favorite_border),
      color: Colors.red,
      onPressed: _toggleQuizCardImportance,
    );
  }

  void _toggleQuizCardImportance() async {
    await cardDao.toggleCardImportance(widget.quizCard.id);
    _status = !_status;
    setState(() {});
  }
}