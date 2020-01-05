import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';

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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // IconButton(
                  //   icon: Icon(Icons.add),
                  //   onPressed: widget.addField,
                  //   color: Theme.of(context).primaryColor,
                  // ),
                  HeadlineText(text: 'Sense'),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => widget.removeField(widget.index),
                    color: Theme.of(context).errorColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(children: children),
            )
          ],
        ),
      ),
    );
  }
}
