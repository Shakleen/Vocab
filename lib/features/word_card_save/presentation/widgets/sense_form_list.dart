import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';

import 'sense_form.dart';

class SenseFormList extends StatefulWidget {
  final List<Map> senseValues = [];
  final List<Widget> _children = [];

  SenseFormList({Key key}) : super(key: key);

  @override
  _SenseFormListState createState() => _SenseFormListState();

  List<WordCardDetails> getSenseValues() {
    // _children.forEach((SenseForm form) {
    // TODO: Get Data from each sense forms
    // });
  }
}

class _SenseFormListState extends State<SenseFormList> {
  @override
  void initState() {
    super.initState();
    widget._children.addAll([
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
      SenseForm(removeField: _removeSenseForm),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget._children,
    );
  }

  void _addNewSenseForm() {
    setState(() {
      widget._children.add(SenseForm(removeField: _removeSenseForm));
    });
  }

  void _removeSenseForm(SenseForm obj) {
    setState(() {
      widget._children.remove(obj);
    });
  }
}
