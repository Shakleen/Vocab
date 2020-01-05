import 'package:flutter/material.dart';

import 'custom_text_field.dart';
import 'increasing_text_fields.dart';

class SenseForm extends StatefulWidget {
  final Function addField, removeField;
  final int index;

  const SenseForm({
    Key key,
    @required this.index,
    @required this.addField,
    @required this.removeField,
  }) : super(key: key);

  @override
  _SenseFormState createState() => _SenseFormState();
}

class _SenseFormState extends State<SenseForm> {
  final List<Widget> children = [];

  @override
  void initState() {
    super.initState();
    children.addAll([
      CustomTextField(
        labelText: 'Definition',
        helperText: 'Giving an instance of',
      ),
      CustomTextField(
        labelText: 'Part of speech',
        helperText: 'Noun',
      ),
      IncreasingTextFields(title: 'Example'),
      IncreasingTextFields(title: 'Synonym'),
      IncreasingTextFields(title: 'Antonym'),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: IconButton(
        icon: Icon(Icons.add),
        onPressed: widget.addField,
        color: Theme.of(context).primaryColor,
      ),
      title: Text('Sense'),
      trailing: IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () => widget.removeField(widget.index),
        color: Theme.of(context).errorColor,
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(children: children),
        )
      ],
    );
  }
}

