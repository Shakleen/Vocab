import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/injection_container.dart';
import 'package:bloc/bloc.dart';

class SearchWordPage<T extends Bloc> extends StatefulWidget {
  final Widget body;

  SearchWordPage({Key key, @required this.body}) : super(key: key);

  @override
  _SearchWordPageState createState() => _SearchWordPageState<T>();
}

class _SearchWordPageState<T extends Bloc> extends State<SearchWordPage<T>> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vocab App")),
      body: BlocProvider(
        builder: (BuildContext context) => sl<T>(),
        child: widget.body,
      ),
    );
  }
}
