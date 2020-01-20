import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:provider/provider.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/quiz_cards.dart';

class TakeQuizPage extends StatelessWidget {
  const TakeQuizPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {},
            tooltip: "Help!",
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<CardDatabase>(context).quizCardDao.getQuizCards(),
        builder: (BuildContext context, AsyncSnapshot<List<QuizCard>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              print('Quiz Cards fetched: ${snapshot.data.length}');
              return QuizCards(quizCards: snapshot.data);
            }
          }

          return Container();
        },
      ),
    );
  }
}
