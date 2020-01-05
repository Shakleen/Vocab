import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class AdditiveTextField extends StatelessWidget {
  final String helperText, labelText;
  final Function addField, removeField;
  final int index;

  AdditiveTextField({
    Key key,
    this.helperText,
    this.labelText,
    @required this.index,
    @required this.addField,
    @required this.removeField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomTextField(helperText: helperText, labelText: labelText),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: addField,
          color: Theme.of(context).primaryColor,
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => removeField(index),
          color: Theme.of(context).errorColor,
        ),
      ],
    );
  }
}

