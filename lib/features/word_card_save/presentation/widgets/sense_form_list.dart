import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';

import 'sense_form.dart';

class SenseFormList extends StatefulWidget {
  final Map<String, dynamic> values = {};
  
  SenseFormList({Key key}) : super(key: key);

  @override
  _SenseFormListState createState() => _SenseFormListState();
}

class _SenseFormListState extends State<SenseFormList> {
  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children.addAll([
      Row(
        children: <Widget>[
          Expanded(child: HeadlineText(text: 'Senses')),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewSenseForm,
            color: Colors.blue,
          ),
        ],
      ),
      SenseForm(
        index: _children.length,
        removeField: _removeSenseForm,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _children,
    );
  }

  void _addNewSenseForm() {
    setState(() {
      _children.add(SenseForm(
        index: _children.length,
        removeField: _removeSenseForm,
      ));
    });
  }

  void _removeSenseForm(int index) {
    setState(() {
      _children.removeAt(index);
    });
  }
}
