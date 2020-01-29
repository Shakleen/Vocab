import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:vocab/core/enums/mastery_levels.dart';
import 'package:vocab/core/ui/widgets/delete_alert_dialog.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/core/util/formatter.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:provider/provider.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/toggle_importance_button.dart';
import 'package:vocab/core/database/card_database.dart' as db;

class QuizCardTile extends StatefulWidget {
  final QuizCard quizCard;

  QuizCardTile({Key key, @required this.quizCard}) : super(key: key);

  @override
  _QuizCardTileState createState() => _QuizCardTileState();
}

class _QuizCardTileState extends State<QuizCardTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.quizCard.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(Icons.delete, color: Colors.white),
        ),
        alignment: Alignment.centerRight,
      ),
      dismissThresholds: {DismissDirection.endToStart: 0.8},
      confirmDismiss: _handleDismissConfirmation,
      onDismissed: _handleOnDismissed,
      child: ListTile(
        leading: CircleAvatar(
          child: Text(widget.quizCard.level.toString()),
          backgroundColor: MASTERY_LEVEL_COLOR[
              getMasteryLevelForLevel(widget.quizCard.level)],
        ),
        title: TitleText(text: widget.quizCard.front),
        subtitle: Text(
          '${widget.quizCard.back}\n${getFormattedDateTime(widget.quizCard.dueDate)}',
        ),
        trailing: ToggleImportanceButton(quizCard: widget.quizCard),
      ),
    );
  }

  Future<bool> _handleDismissConfirmation(DismissDirection direction) async {
    final bool decision = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return DeleteALertDIalog(
          title: "Confirm delete",
          content: 'Do you really want to delete this quiz card?"',
        );
      },
    );

    return decision;
  }

  void _handleOnDismissed(DismissDirection direction) async {
    final bool result =
        await Provider.of<db.CardDatabase>(context, listen: false)
            .quizCardDao
            .deleteQuizCard(widget.quizCard.id);
    print('Deletion result: $result');
  }
}
