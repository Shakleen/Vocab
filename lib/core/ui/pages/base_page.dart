import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/search_app_bar.dart';
import 'package:vocab/features/query_word/presentation/bloc/query_word_bloc.dart';
import 'package:vocab/features/query_word/presentation/widgets/query_word_body.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';
import 'package:vocab/features/word_card/presentation/widgets/word_card_body.dart';
import 'package:vocab/injection_container.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WordCardBloc>(
      create: (BuildContext context) => sl<WordCardBloc>(),
      child: BlocProvider<QueryWordBloc>(
        create: (BuildContext context) => sl<QueryWordBloc>(),
        child: SafeArea(
          child: Scaffold(
            appBar: SearchAppBar(
              tabBar: TabBar(
                controller: _controller,
                tabs: <Widget>[
                  Tab(text: 'Oxford Dictionary'),
                  Tab(text: 'Words API'),
                ],
              ),
            ),
            body: TabBarView(
              controller: _controller,
              children: <Widget>[QueryWordBody(), WordCardBody()],
            ),
          ),
        ),
      ),
    );
  }
}
