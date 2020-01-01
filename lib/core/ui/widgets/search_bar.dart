import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';

class SearchBar<T extends Bloc> extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState<T>();
}

class _SearchBarState<T extends Bloc> extends State<SearchBar<T>> {
  final TextEditingController controller = TextEditingController();
  String _queryWord;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "example",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35.0),
                ),
                hintStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              keyboardType: TextInputType.text,
              onChanged: (String value) => _queryWord = value,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              BlocProvider.of<T>(context).add(_getEvent());
            },
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _getEvent() {
    switch(T) {
      case WordCardBloc: return GetWordCardEvent(queryWord: _queryWord);
      case QueryWordBloc: return GetWordEntryEvent(queryWord: _queryWord);
    }
  }
}
