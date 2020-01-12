import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/subtitle_text.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';

class QuizCards extends StatefulWidget {
  final List<QuizCard> quizCards;

  QuizCards({Key key, @required this.quizCards}) : super(key: key);

  @override
  _QuizCardsState createState() => _QuizCardsState();
}

class _QuizCardsState extends State<QuizCards> {
  int _index;
  QuizControls _controls;
  List<Widget> _children;

  @override
  void initState() {
    super.initState();
    _index = 0;
    _buildChildren();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: _children,
    );
  }

  void _revealAnswer() {
    setState(() {
      _children = <Widget>[
        Expanded(
          flex: 1,
          child: FrontWidget(quizCard: widget.quizCards[_index]),
        ),
        Divider(color: Colors.grey, height: 2, thickness: 2),
        Expanded(
          flex: 5,
          child: BackWidget(quizCard: widget.quizCards[_index]),
        ),
        _controls,
      ];
    });
  }

  void _nextCard() {
    if (_index < widget.quizCards.length) {
      setState(() {
        _index += 1;
        _buildChildren();
      });
    } else {
      Navigator.pop(context);
    }
  }

  void _buildChildren() {
    _controls = QuizControls(
      next: _nextCard,
      reveal: _revealAnswer,
      level: widget.quizCards[_index].level,
    );
    _children = <Widget>[
      Expanded(
        flex: 1,
        child: FrontWidget(quizCard: widget.quizCards[_index]),
      ),
      _controls,
    ];
  }
}

class FrontWidget extends StatelessWidget {
  final QuizCard quizCard;

  FrontWidget({Key key, @required this.quizCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> _children = [];

    switch (quizCard.frontType) {
      case 1:
        _children.add(TitleText(text: "Spelling"));
        _children.add(Text(quizCard.front));
        break;
      case 2:
        _children.add(TitleText(text: "Pronunciation"));
        _children.add(Text(quizCard.front));
        break;
      case 4:
        _children.add(TitleText(text: "Examples"));
        _makeOrderedList(_children, quizCard.front);
        break;
      case 5:
        _children.add(TitleText(text: "Definition"));
        _children.add(Text(quizCard.front));
        break;
    }

    switch (quizCard.backType) {
      case 1:
        _children.add(
          _makeQuestion("Spell the word \"${quizCard.word}\"."),
        );
        break;
      case 2:
        _children.add(
          _makeQuestion("Pronounce the word \"${quizCard.word}\""),
        );
        break;
      case 3:
        _children.add(
          _makeQuestion(
            "Mention how many syllables the word \"${quizCard.word}\" has." +
                " And mention the syllables as well",
          ),
        );
        break;
      case 4:
        _children.add(
          _makeQuestion(
              "Give some example uses of the word \"${quizCard.word}\"."),
        );
        break;
      case 5:
        _children.add(
          _makeQuestion(
            "Define the meaning of the word \"${quizCard.word}\" in this context.",
          ),
        );
        break;
      case 6:
        _children.add(
          _makeQuestion(
              "Mention some synonyms of the word \"${quizCard.word}\""),
        );
        break;
      case 7:
        _children.add(
          _makeQuestion(
              "Mention some antonyms of the word \"${quizCard.word}\""),
        );
        break;
      case 8:
        _children.add(
          _makeQuestion(
              "Mention the part of speech the word \"${quizCard.word}\" belongs to"),
        );
        break;
    }

    return _children;
  }

  Widget _makeQuestion(String question) => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: SubtitleText(text: question),
      );

  void _makeOrderedList(List<Widget> _children, String data) {
    final List<String> pieces = data.split(' | ');
    for (int i = 1; i <= pieces.length; ++i)
      _children.add(Text("$i) ${pieces[i - 1]}"));
  }
}

class BackWidget extends StatelessWidget {
  final QuizCard quizCard;

  BackWidget({Key key, @required this.quizCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    final List<Widget> _children = [];

    switch (quizCard.backType) {
      case 1:
        _children.add(TitleText(text: "Spelling"));
        _children.add(Text(quizCard.back));
        break;
      case 2:
        _children.add(TitleText(text: "Pronunciation"));
        _children.add(Text(quizCard.back));
        break;
      case 3:
        _children.add(TitleText(text: "Syllables of \"${quizCard.word}\""));
        _children.add(Text(quizCard.back));
        break;
      case 4:
        _children.add(TitleText(text: "Examples of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case 5:
        _children.add(TitleText(text: "Definition of \"${quizCard.word}\""));
        _children.add(Text(quizCard.back));
        break;
      case 6:
        _children.add(TitleText(text: "Synonyms of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case 7:
        _children.add(TitleText(text: "Antonyms of \"${quizCard.word}\""));
        _makeOrderedList(_children);
        break;
      case 8:
        _children
            .add(TitleText(text: "Part of Speech of \"${quizCard.word}\""));
        _children.add(Text(quizCard.back));
        break;
    }

    return _children;
  }

  void _makeOrderedList(List<Widget> _children) {
    final List<String> pieces = quizCard.back.split(' | ');
    for (int i = 1; i <= pieces.length; ++i)
      _children.add(Text("$i) ${pieces[i - 1]}"));
  }
}

class QuizControls extends StatefulWidget {
  final Function next;
  final Function reveal;
  final int level;

  QuizControls({
    Key key,
    @required this.next,
    @required this.reveal,
    @required this.level,
  }) : super(key: key);

  @override
  _QuizControlsState createState() => _QuizControlsState();
}

class _QuizControlsState extends State<QuizControls> {
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: _getChild(),
    );
  }

  Widget _getChild() {
    if (_revealed) {
      return ButtonBar(
        buttonMinWidth: 100,
        buttonHeight: 65,
        alignment: MainAxisAlignment.spaceAround,
        buttonTextTheme: ButtonTextTheme.primary,
        children: <Widget>[
          RaisedButton(
            child: Text(
              "Again\n(1 min)",
              textAlign: TextAlign.center,
            ),
            color: Colors.red,
            onPressed: () {},
          ),
          RaisedButton(
            child: Text(
              "Good\n${_getTime()}",
              textAlign: TextAlign.center,
            ),
            color: Colors.green,
            onPressed: () {},
          ),
        ],
      );
    } else {
      return RaisedButton(
        child: Text("Reveal"),
        textTheme: ButtonTextTheme.primary,
        color: Theme.of(context).primaryColor,
        onPressed: () {
          setState(() {
            widget.reveal();
            _revealed = true;
          });
        },
      );
    }
  }

  String _getTime() {
    if (widget.level == 0) {
      return "10 minutes";
    } else if (widget.level == 1) {
      return "1 day";
    } else if (widget.level < 15) {
      return "${2 * widget.level - 1} day";
    } else {
      return "${widget.level / 15} month";
    }
  }
}
