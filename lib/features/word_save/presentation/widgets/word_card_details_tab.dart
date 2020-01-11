import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/ui/widgets/word_info_widget.dart';

class WordCardDetailsTab extends StatelessWidget {
  final String word;

  const WordCardDetailsTab({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CardDatabase>(context).wordDao.getWordCard(word),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          return WordInfoWidget(wordCard: snapshot.data);
        }

        return Container();
      },
    );
  }
}
