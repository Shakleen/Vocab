import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/ui/widgets/word_info_widget.dart';

class ShowWordInfoPage extends StatelessWidget {
  final String word;

  const ShowWordInfoPage({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<CardDatabase>(context).wordDao.getWordCard(word),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return WordInfoWidget(wordCard: snapshot.data);
            }
          }

          return Container();
        },
      ),
    );
  }
}
