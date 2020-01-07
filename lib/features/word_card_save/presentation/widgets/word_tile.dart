
import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/navigation/routes.dart';

class WordTile extends StatefulWidget {
  final String word;
  final int senseCount;

  const WordTile({Key key, @required this.word, this.senseCount = 0})
      : super(key: key);

  @override
  _WordTileState createState() => _WordTileState();
}

class _WordTileState extends State<WordTile> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(widget.word),
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
              '${widget.senseCount}',
            ),
          ),
          title: Text(widget.word),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '${Page.ShowWordInfoPage}',
            arguments: widget.word,
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
        return AlertDialog(
          title: Text(
            "Confirm delete",
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          content: Text('Do you really want to delete "${widget.word}?"'),
          actions: <Widget>[
            RaisedButton(
              child: Text("Delete"),
              onPressed: () => Navigator.pop(context, true),
              color: Theme.of(context).errorColor,
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context, false),
            )
          ],
        );
      },
    );

    return decision;
  }

  void _handleOnDismissed(DismissDirection direction) async {
    final bool result = await Provider.of<CardDatabase>(context, listen: false)
        .wordDao
        .deleteWordCard(widget.word);
    print('Deletion result: $result');
  }
}