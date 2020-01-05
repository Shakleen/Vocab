import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';

import 'additive_text_field.dart';

class IncreasingTextFields extends StatefulWidget {
  final String title;

  IncreasingTextFields({Key key, @required this.title}) : super(key: key);

  @override
  _IncreasingTextFieldsState createState() => _IncreasingTextFieldsState();
}

class _IncreasingTextFieldsState extends State<IncreasingTextFields> {
  final List<Widget> fields = [];

  @override
  void initState() {
    super.initState();
    fields.addAll([
      Row(
        children: <Widget>[
          Expanded(child: TitleText(text: widget.title)),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewField,
            color: Colors.blue,
          ),
        ],
      ),
      AdditiveTextField(
        index: 0,
        labelText: widget.title,
        removeField: _removeField,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: fields,
    );
  }

  void _addNewField() {
    setState(() {
      fields.add(AdditiveTextField(
        labelText: widget.title,
        index: fields.length,
        removeField: _removeField,
      ));
    });
  }

  void _removeField(int index) {
    setState(() {
      fields.removeAt(index);
    });
  }
}
