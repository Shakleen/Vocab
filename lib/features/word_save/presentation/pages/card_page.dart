import 'package:flutter/material.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';
import 'package:vocab/features/word_save/presentation/widgets/view_saved_words.dart';
import 'package:vocab/features/word_save/presentation/widgets/word_statistics.dart';

class CardPage extends StatefulWidget {
  CardPage({Key key}) : super(key: key);

  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add new word entry',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '${Page.CardFormPage}',
                arguments: {
                  'isEditing': false,
                },
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[Tab(text: 'Statistics'), Tab(text: 'Saved')],
        ),
      ),
      drawer: SideDrawer(page: Page.CardPage),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[WordStatistics(), ViewSavedWords()],
      ),
    );
  }
}
