import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/search_app_bar.dart';
import 'package:vocab/injection_container.dart';
import 'package:bloc/bloc.dart';

class BasePage<T extends Bloc> extends StatefulWidget {
  final Widget body;

  const BasePage({Key key, @required this.body}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState<T>();
}

class _BasePageState<T extends Bloc> extends State<BasePage<T>> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<T>(
      create: (BuildContext context) => sl<T>(),
      child: Scaffold(
        appBar: SearchAppBar<T>(),
        body: widget.body,
      ),
    );
  }
}
