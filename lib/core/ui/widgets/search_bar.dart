import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/database/card_database.dart' as db;
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search a word...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          hintStyle: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        keyboardType: TextInputType.text,
        onSubmitted: (String value) {
          BlocProvider.of<WordCardBloc>(context).add(
            GetWordCardEvent(queryWord: value),
          );
          BlocProvider.of<QueryWordBloc>(context).add(
            GetWordEntryEvent(queryWord: value),
          );
          Provider.of<db.CardDatabase>(context)
              .wordDao
              .handleWordsSearchUsageInfo();
        },
      ),
    );
  }
}
