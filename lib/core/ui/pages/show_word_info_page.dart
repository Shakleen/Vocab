import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:provider/provider.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/quiz_card_tab.dart';
import 'package:vocab/features/word_save/presentation/widgets/word_card_details_tab.dart';

class ShowWordInfoPage extends StatefulWidget {
  final String word;

  const ShowWordInfoPage({Key key, @required this.word}) : super(key: key);

  @override
  _ShowWordInfoPageState createState() => _ShowWordInfoPageState();
}

class _ShowWordInfoPageState extends State<ShowWordInfoPage>
    with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<CardDatabase>(context).wordDao.getWordCard(widget.word),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: AppTitle(),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                disabledColor: Colors.grey[300],
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '${Page.CardFormPage}',
                    arguments: {
                      'wordCard': snapshot.data,
                      'isEditing': true,
                    },
                  );
                },
              )
            ],
            bottom: TabBar(
              controller: _controller,
              tabs: <Widget>[
                Tab(text: 'Word details'),
                Tab(text: 'Quiz cards'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _controller,
            children: <Widget>[
              WordCardDetailsTab(word: widget.word),
              QuizCardTab(),
            ],
          ),
        );
      },
    );
  }
}
