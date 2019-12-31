import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function (String) search;

  SearchBar({Key key, @required this.search}) : super(key: key);

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
              onPressed: () {
                controller.clear();
                widget.search(_queryWord);
              },
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}