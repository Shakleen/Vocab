import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';

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
          children: [
            Center(
                child: DisplayWordText(
              text: widget.initialWordCard == null
                  ? 'Enter New Word'
                  : 'Edit Existing Word',
            )),
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
            Center(child: HeadlineText(text: 'Senses')),
            SenseForms(),
          ],
        ),
      ),
    );
  }

  void _submit() {}
}

class SenseForms extends StatefulWidget {
  SenseForms({Key key}) : super(key: key);

  @override
  _SenseFormsState createState() => _SenseFormsState();
}

class _SenseFormsState extends State<SenseForms> {
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

class SenseForm extends StatelessWidget {
  final Function addField, removeField;
  final int index;

  const SenseForm({
    Key key,
    @required this.index,
    @required this.addField,
    @required this.removeField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: IconButton(
        icon: Icon(Icons.add),
        onPressed: addField,
        color: Theme.of(context).primaryColor,
      ),
      title: Text('Sense'),
      trailing: IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () => removeField(index),
        color: Theme.of(context).errorColor,
      ),
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
  final List<Widget> fields = [];

  @override
  void initState() {
    super.initState();
    fields.addAll([
      TitleText(text: widget.title),
      AdditiveTextField(
        index: 0,
        labelText: widget.title,
        addField: _addNewField,
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
        addField: _addNewField,
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

class AdditiveTextField extends StatelessWidget {
  final String helperText, labelText;
  final Function addField, removeField;
  final int index;

  AdditiveTextField({
    Key key,
    this.helperText,
    this.labelText,
    @required this.index,
    @required this.addField,
    @required this.removeField,
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
          onPressed: () => removeField(index),
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
