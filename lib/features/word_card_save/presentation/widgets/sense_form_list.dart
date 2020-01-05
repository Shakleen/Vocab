import 'package:flutter/material.dart';

import 'sense_form.dart';

class SenseFormList extends StatefulWidget {
  SenseFormList({Key key}) : super(key: key);

  @override
  _SenseFormListState createState() => _SenseFormListState();
}

class _SenseFormListState extends State<SenseFormList> {
  final List<Widget> _children = [];

  @override
  void initState() {
    super.initState();
    _children.add(SenseForm(
      index: _children.length,
      addField: _addNewSenseForm,
      removeField: _removeSenseForm,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _children,
    );
  }

  void _addNewSenseForm() {
    setState(() {
      _children.add(SenseForm(
        index: _children.length,
        addField: _addNewSenseForm,
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

