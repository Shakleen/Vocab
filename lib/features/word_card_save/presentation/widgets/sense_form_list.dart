import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';

import 'sense_form.dart';

class SenseFormList extends StatefulWidget {
  final List<WordCardDetails> initSenses;
  final List<Map> senseValues = [];
  final List<Widget> _children = [];

  SenseFormList({Key key, this.initSenses}) : super(key: key);

  @override
  _SenseFormListState createState() => _SenseFormListState();

  List<WordCardDetails> getSenseValues() {
    final List<WordCardDetails> returnList = [];
    _children.forEach((Widget child) {
      if (child is SenseForm) returnList.add(child.getSenseFormValues());
    });
    return returnList;
  }
}

class _SenseFormListState extends State<SenseFormList> {
  @override
  void initState() {
    super.initState();

    widget._children.add(
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
    );
    if (widget.initSenses == null) {
      widget._children.add(SenseForm(removeField: _removeSenseForm));
    } else {
      widget.initSenses.forEach((WordCardDetails sense) {
        widget._children.add(
          SenseForm(removeField: _removeSenseForm, initSense: sense),
        );
      });
    }
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
