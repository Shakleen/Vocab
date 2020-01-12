import 'package:flutter/material.dart';
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
    _controls = QuizControls(next: _nextCard, reveal: _revealAnswer);
    _children = <Widget>[
      Expanded(
        flex: 1,
        child: FrontWidget(quizCard: widget.quizCards[_index]),
      ),
      _controls,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _children,
      ),
    );
  }

  void _revealAnswer() {
    setState(() {
      _children = <Widget>[
        Expanded(
          flex: 1,
          child: FrontWidget(quizCard: widget.quizCards[_index]),
        ),
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
      });
    } else {
      Navigator.pop(context);
    }
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
        final List<String> pieces = quizCard.front.split(' | ');
        for (int i = 1; i <= pieces.length; ++i)
          _children.add(Text("$i) ${pieces[i - 1]}"));
        break;
      case 5:
        _children.add(TitleText(text: "Definition"));
        _children.add(Text(quizCard.front));
        break;
    }

    return _children;
  }
}

class BackWidget extends StatelessWidget {
  final QuizCard quizCard;

  BackWidget({Key key, @required this.quizCard}) : super(key: key);

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
        _children.add(TitleText(text: "Syllables"));
        _children.add(Text(quizCard.back));
        break;
      case 4:
        _children.add(TitleText(text: "Examples"));
        _makeOrderedList(_children);
        break;
      case 5:
        _children.add(TitleText(text: "Definition"));
        _children.add(Text(quizCard.back));
        break;
      case 6:
        _children.add(TitleText(text: "Synonyms"));
        _makeOrderedList(_children);
        break;
      case 7:
        _children.add(TitleText(text: "Antonyms"));
        _makeOrderedList(_children);
        break;
      case 8:
        _children.add(TitleText(text: "Part of Speech"));
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

  QuizControls({
    Key key,
    @required this.next,
    @required this.reveal,
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
        alignment: MainAxisAlignment.spaceAround,
        buttonTextTheme: ButtonTextTheme.primary,
        children: <Widget>[
          RaisedButton(
            child: Text("Again"),
            color: Colors.red,
            onPressed: () {},
          ),
          RaisedButton(
            child: Text("Good"),
            color: Colors.green,
            onPressed: () {},
          ),
          RaisedButton(
            child: Text("Easy"),
            color: Colors.blue,
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
}
