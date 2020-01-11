import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:provider/provider.dart';
import 'package:vocab/features/quiz_card/presentation/widgets/quiz_card_tile.dart';

class QuizCardTab extends StatelessWidget {
  final String word;

  const QuizCardTab({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CardDatabase>(context).cardDao.getQuizCards(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return QuizCardTile(quizCard: snapshot.data[index]);
            },
          );
        }

        return Container();
      },
    );
  }
}


