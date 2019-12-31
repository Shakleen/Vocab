import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController controller = TextEditingController();
  String _queryWord;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 5,
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
        Expanded(
          flex: 1,
          child: CircleAvatar(
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: _submit,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  void _submit() {
    controller.clear();
    BlocProvider.of<QueryWordBloc>(context).add(
      GetWordEntryEvent(queryWord: _queryWord),
    );
  }
}