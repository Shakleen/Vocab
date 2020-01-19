import 'package:flutter/material.dart';
import 'package:vocab/core/enums/part_of_speech.dart';

class PartOfSpeechDropDown extends StatefulWidget {
  final PartOfSpeechType partOfSpeech;
  int choice;

  PartOfSpeechDropDown({Key key, this.partOfSpeech}) : super(key: key);

  @override
  _PartOfSpeechDropDownState createState() => _PartOfSpeechDropDownState();
}

class _PartOfSpeechDropDownState extends State<PartOfSpeechDropDown> {
  List<String> _posNames;

  @override
  void initState() {
    super.initState();

    if (widget.partOfSpeech != null) {
      widget.choice = PART_OF_SPEECH_TYPE_TO_ID[widget.partOfSpeech];
    } else {
      widget.choice = 1;
    }

    _posNames = List.generate(8, (int index) {
      return getPartOfSpeechString(ID_TO_PART_OF_SPEECH_TYPE[index + 1]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      items: List<DropdownMenuItem<int>>.generate(
        _posNames.length,
        (int index) => DropdownMenuItem(
          child: Text(_posNames[index]),
          value: index + 1,
        ),
      ),
      onChanged: _handleOnChanged,
      icon: Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      value: widget.choice,
      isExpanded: true,
      style: TextStyle(color: Theme.of(context).primaryColor),
    );
  }

  void _handleOnChanged(int value) {
    setState(() {
      widget.choice = value;
    });
  }
}
