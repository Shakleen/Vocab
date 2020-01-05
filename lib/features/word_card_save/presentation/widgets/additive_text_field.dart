import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class AdditiveTextField extends StatelessWidget {
  final String helperText, labelText;
  final Function(AdditiveTextField) removeField;
  CustomTextField _field;

  AdditiveTextField({
    Key key,
    this.helperText,
    this.labelText,
    @required this.removeField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _field = CustomTextField(helperText: helperText, labelText: labelText);
    return Row(
      children: <Widget>[
        Expanded(child: _field),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () => removeField(this),
          color: Theme.of(context).errorColor,
        ),
      ],
    );
  }

  String getText() {
    return _field.controller.text;
  }
}
