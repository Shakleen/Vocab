import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/core/util/formatter.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';

class QuizCardTile extends StatelessWidget {
  final QuizCard quizCard;

  const QuizCardTile({
    Key key,
    @required this.quizCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(quizCard.level.toString()),
          backgroundColor: _chooseColor(),
        ),
        title: TitleText(text: quizCard.front),
        subtitle: Text(
          '${quizCard.back}\n${getFormattedDateTime(quizCard.dueDate)}',
        ),
        trailing: Icon(
          quizCard.isImportant ? Icons.favorite : Icons.favorite_border,
        ),
      ),
    );
  }

  Color _chooseColor() {
    if (quizCard.level == 0)
      return Colors.grey[350];
    else if (quizCard.level <= 2)
      return Colors.yellow;
    else if (quizCard.level <= 15)
      return Colors.lightGreen;
    else
      return Colors.green[900];
  }
}
