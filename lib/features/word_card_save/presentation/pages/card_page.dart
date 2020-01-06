import 'package:flutter/material.dart';
import 'package:vocab/core/entities/pronunciation.dart';
import 'package:vocab/core/entities/syllable.dart' as s;
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';
import 'package:provider/provider.dart';
import 'package:vocab/features/word_card_save/data/data_source/card_database.dart';
import 'package:vocab/injection_container.dart';

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
              Navigator.pushNamed(context, '${Page.CardFormPage}');
            },
          ),
        ],
        bottom: TabBar(
          controller: _controller,
          tabs: <Widget>[
            Tab(text: 'Statistics'),
            Tab(text: 'Saved'),
          ],
        ),
      ),
      drawer: SideDrawer(page: Page.CardPage),
      body: Provider<CardDatabase>(
        create: (BuildContext context) => sl(),
        child: TabBarView(
          controller: _controller,
          children: <Widget>[Container(), ViewSavedWords()],
        ),
      ),
    );
  }
}

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
                return ListTile(title: Text(snapshot.data[index]));
              },
            );
          }
        }

        return Container();
      },
    );
  }
}
