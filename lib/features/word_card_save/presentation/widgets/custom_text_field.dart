import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String helperText, labelText;
  final TextEditingController controller = TextEditingController();

  CustomTextField({Key key, this.helperText, this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        onChanged: _handleOnChange,
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

  void _handleOnChange(String value) {}
}
