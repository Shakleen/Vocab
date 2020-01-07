import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/ui/widgets/word_info_widget.dart';

class ShowWordInfoPage extends StatelessWidget {
  final String word;

  const ShowWordInfoPage({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CardDatabase>(context).wordDao.getWordCard(word),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Widget body = Container();
        Function onEditTapped;
        if (snapshot.connectionState == ConnectionState.active) {
          body = Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            body = WordInfoWidget(wordCard: snapshot.data);
            onEditTapped = () {
              Navigator.pushNamed(
                context,
                '${Page.CardFormPage}',
                arguments: snapshot.data,
              );
            };
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: AppTitle(),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                disabledColor: Colors.grey[300],
                onPressed: onEditTapped,
              )
            ],
          ),
          body: body,
        );
      },
    );
  }
}
