import 'package:flutter/material.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(), 
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () {},),
        ],
      ),
      drawer: SideDrawer(page: Page.CardPage),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[QueryWordBody(), WordCardBody()],
      ),
    );
  }
}
