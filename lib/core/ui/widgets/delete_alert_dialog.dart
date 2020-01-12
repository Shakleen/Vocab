import 'package:flutter/material.dart';

class DeleteALertDIalog extends StatelessWidget {
  final String content, title;
  const DeleteALertDIalog({
    Key key,
    this.content,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
      content: Text(content),
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
  }
}