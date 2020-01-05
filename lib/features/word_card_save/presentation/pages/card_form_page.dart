import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';

class CardFormPage extends StatefulWidget {
  final WordCard initialWordCard;

  CardFormPage({Key key, this.initialWordCard}) : super(key: key);

  @override
  _CardFormPageState createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  final GlobalKey _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final String headline = widget.initialWordCard == null
        ? 'Enter New Word'
        : 'Edit Existing Word';
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: _submit,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            Center(child: DisplayWordText(text: headline)),
            CustomTextField(
              labelText: 'Word',
              helperText: 'e.g. example',
            ),
            CustomTextField(
              labelText: 'Pronunciation',
              helperText: 'Audio file link',
            ),
            CustomTextField(
              labelText: 'Syllables',
              helperText: 'e.g. ex-am-ple',
            ),
            SenseForm(),
          ],
        ),
      ),
    );
  }

  void _submit() {}
}

class SenseForm extends StatelessWidget {
  const SenseForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Sense #1'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              CustomTextField(
                labelText: 'Definition',
                helperText: 'Giving an instance of',
              ),
              CustomTextField(
                labelText: 'Part of speech',
                helperText: 'Noun',
              ),
              // CustomTextField(
              //   labelText: 'Example sentences',
              //   helperText:
              //       'e.g. The teacher gave many examples for the students to understand',
              // ),
              // CustomTextField(
              //   labelText: 'Synonyms',
              //   helperText: 'e.g. ',
              // ),
              // CustomTextField(
              //   labelText: 'Antonyms',
              //   helperText: 'e.g. ',
              // ),
              IncreasingTextFields(title: 'Example'),
              IncreasingTextFields(title: 'Synonym'),
              IncreasingTextFields(title: 'Antonym'),
            ],
          ),
        )
      ],
    );
  }
}

class IncreasingTextFields extends StatefulWidget {
  final String title;

  IncreasingTextFields({Key key, @required this.title}) : super(key: key);

  @override
  _IncreasingTextFieldsState createState() => _IncreasingTextFieldsState();
}

class _IncreasingTextFieldsState extends State<IncreasingTextFields> {
  final List<AdditiveTextField> fields = [];

  @override
  void initState() {
    super.initState();
    fields.add(AdditiveTextField(
      labelText: widget.title,
      addField: _addNewField,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: fields,
    );
  }

  void _addNewField() {
    setState(() {
      fields.add(AdditiveTextField(
        labelText: widget.title,
        addField: _addNewField,
      ));
    });
  }
}

class AdditiveTextField extends StatelessWidget {
  final String helperText, labelText;
  Function addField;

  AdditiveTextField({
    Key key,
    this.helperText,
    this.labelText,
    @required this.addField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: CustomTextField(helperText: helperText, labelText: labelText),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: addField,
          color: Theme.of(context).primaryColor,
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {},
          color: Theme.of(context).errorColor,
        ),
      ],
    );
  }
}

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
