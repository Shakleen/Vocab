import 'package:flutter/material.dart';

class SearchWordPage extends StatefulWidget {
  SearchWordPage({Key key}) : super(key: key);

  @override
  _SearchWordPageState createState() => _SearchWordPageState();
}

class _SearchWordPageState extends State<SearchWordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vocab App"),
      ),
      body: Container(),
    );
  }
}