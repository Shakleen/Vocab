import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:provider/provider.dart';

import 'word_tile.dart';

class ViewSavedWords extends StatelessWidget {
  const ViewSavedWords({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<CardDatabase>(context).wordDao.getSavedWords(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return WordTile(word: snapshot.data[index]);
              },
            );
          }
        }

        return Container();
      },
    );
  }
}


