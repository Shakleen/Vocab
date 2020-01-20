import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/delete_alert_dialog.dart';
import 'package:vocab/core/util/formatter.dart';
import 'package:vocab/features/show_saved_words/domain/entity/word_details_summary.dart';

class WordTile extends StatefulWidget {
  final WordDetailsSummary wordSummary;

  const WordTile({Key key, @required this.wordSummary}) : super(key: key);

  @override
  _WordTileState createState() => _WordTileState();
}

class _WordTileState extends State<WordTile> {
  @override
  Widget build(BuildContext context) {
    final String formattedDate = getFormattedDateTime(
      widget.wordSummary.addedOn,
    );

    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(widget.wordSummary.word),
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
      child: InkWell(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              '${widget.wordSummary.senses}',
            ),
          ),
          title: Text(widget.wordSummary.word),
          subtitle: Text('Added on $formattedDate'),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '${Page.ShowWordInfoPage}',
            arguments: widget.wordSummary.word,
          );
        },
        splashColor: Theme.of(context).primaryColorLight,
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
          content: 'Do you really want to delete "${widget.wordSummary.word}?"',
        );
      },
    );

    return decision;
  }

  void _handleOnDismissed(DismissDirection direction) async {
    final bool result = await Provider.of<CardDatabase>(context, listen: false)
        .wordDao
        .deleteWordCard(widget.wordSummary.word);
    print('Deletion result: $result');
  }
}
