import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/display_word_text.dart';
import 'package:vocab/core/database/card_database.dart' as db;
import 'package:vocab/core/ui/widgets/notifier.dart';
import 'package:vocab/features/word_save/domain/entity/word_details_keys.dart';
import 'package:vocab/features/word_save/presentation/bloc/bloc.dart';
import 'package:vocab/features/word_save/presentation/widgets/custom_text_field.dart';
import 'package:vocab/features/word_save/presentation/widgets/sense_form_list.dart';
import 'package:vocab/injection_container.dart';

const String SEPERATOR = " | ";

class CardFormPage extends StatefulWidget {
  final WordCard initialWordCard;
  final bool isEditing;

  CardFormPage({
    Key key,
    this.initialWordCard,
    this.isEditing = false,
  }) : super(key: key);

  @override
  _CardFormPageState createState() => _CardFormPageState();
}

class _CardFormPageState extends State<CardFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  CustomTextField wordField, pronunciationField, syllablesField;
  SenseFormList senseFormList;
  db.WordDao _wordDao;
  WordSaveBloc _bloc;

  @override
  void initState() {
    super.initState();
    db.CardDatabase cardDatabase = sl();
    _wordDao = cardDatabase.wordDao;
    wordField = CustomTextField(
      initValue: widget.initialWordCard?.word,
      labelText: 'Word',
    );
    pronunciationField = CustomTextField(
      initValue: widget.initialWordCard?.pronunciation,
      labelText: 'Pronunciation',
    );
    syllablesField = CustomTextField(
      initValue: widget.initialWordCard?.syllables?.join(SEPERATOR),
      labelText: "Syllables",
    );
    senseFormList = SenseFormList(
      initSenses: widget.initialWordCard?.detailList,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = sl();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordSaveBloc, WordSaveState>(
      bloc: _bloc,
      builder: (BuildContext context, WordSaveState state) {
        return Scaffold(
          appBar: AppBar(
            title: AppTitle(),
            actions: _buildActions(state),
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  void _submit() async {
    if (!_formKey.currentState.validate()) return;

    Map<String, dynamic> wordDetails = _makeWordDetails();

    if (widget.isEditing) {
      _bloc.add(UpdateWordEvent(wordDetails));
    } else {
      _bloc.add(InsertWordEvent(wordDetails));
    }
  }

  Map<String, dynamic> _makeWordDetails() {
    return <String, dynamic>{
      getWordDetailKeyString(WordDetailKeys.id): widget.initialWordCard?.id,
      getWordDetailKeyString(WordDetailKeys.word):
          wordField.controller.value.text,
      getWordDetailKeyString(WordDetailKeys.pronunciation):
          pronunciationField.controller.value.text,
      getWordDetailKeyString(WordDetailKeys.syllables):
          syllablesField.controller.value.text,
      getWordDetailKeyString(WordDetailKeys.senses):
          senseFormList.getSenseValues(),
    };
  }

  Widget _buildBody(WordSaveState state) {
    if (state is InitialWordSaveState) {
      return Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Center(
              child: DisplayWordText(
                text: widget.isEditing ? 'Edit existing' : 'Add new',
              ),
            ),
            wordField,
            pronunciationField,
            syllablesField,
            senseFormList,
          ],
        ),
      );
    } else if (state is ProcessingWordSaveState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Processing. Please wait.",
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Center(child: LinearProgressIndicator()),
        ],
      );
    } else if (state is FinishedWordSaveState) {
      return Notifier(
        text: widget.isEditing
            ? "Changes successfully saved!"
            : "Word successfully saved",
        color: Colors.green,
        icon: Icons.done,
      );
    } else if (state is ErrorWordSaveState) {
      return Notifier(
        text: widget.isEditing
            ? "Changes could not be saved!"
            : "Word could not be saved",
        color: Colors.red,
        icon: Icons.clear,
      );
    }
  }

  List<Widget> _buildActions(WordSaveState state) {
    if (state is InitialWordSaveState) {
      return <Widget>[IconButton(icon: Icon(Icons.done), onPressed: _submit)];
    } else {
      return <Widget>[IconButton(icon: Icon(Icons.done), disabledColor: Colors.blue)];
    }
  }
}


