import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String helperText, labelText, initValue;
  final TextEditingController controller;
  final bool isNullable;

  CustomTextField({
    Key key,
    this.initValue,
    this.helperText,
    this.labelText,
    this.isNullable = false,
  })  : controller = TextEditingController(text: initValue),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        validator: _validate,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
          helperText: helperText,
          labelText: labelText,
        ),
      ),
    );
  }

  String _validate(String value) {
    if (isNullable == false) {
      if (value.isEmpty) return "Can not be empty!";
    }
  }
}
