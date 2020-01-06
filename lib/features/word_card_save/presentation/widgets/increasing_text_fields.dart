import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';

import 'additive_text_field.dart';

class IncreasingTextFields extends StatefulWidget {
  final String title;
  final List<String> initValue;
  final List<Widget> _children = [];

  IncreasingTextFields({
    Key key,
    @required this.title,
    this.initValue,
  }) : super(key: key);

  @override
  _IncreasingTextFieldsState createState() => _IncreasingTextFieldsState();

  List<String> getFormTextStrings() {
    final List<String> formTexts = [];

    _children.forEach((Widget child) {
      if (child is AdditiveTextField) {
        final String str = child.getText();
        if (str.isNotEmpty) formTexts.add(str);
      }
    });

    return formTexts;
  }
}

class _IncreasingTextFieldsState extends State<IncreasingTextFields> {
  @override
  void initState() {
    super.initState();
    widget._children.add(
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
    );

    if (widget.initValue == null) {
      widget._children.add(AdditiveTextField(
        labelText: widget.title,
        removeField: _removeField,
      ));
    } else {
      widget.initValue.forEach((String value) {
        widget._children.add(AdditiveTextField(
          initValue: value,
          labelText: widget.title,
          removeField: _removeField,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: widget._children,
    );
  }

  void _addNewField() {
    setState(() {
      widget._children.add(
        AdditiveTextField(labelText: widget.title, removeField: _removeField),
      );
    });
  }

  void _removeField(AdditiveTextField obj) {
    setState(() {
      widget._children.remove(obj);
    });
  }
}
