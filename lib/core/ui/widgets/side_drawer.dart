import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vocab/core/navigation/routes.dart';

import 'headline_text.dart';

class SideDrawer extends StatelessWidget {
  final Page page;
  const SideDrawer({Key key, @required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text("shakleenishfar@gmail.com"),
            accountName: HeadlineText(
              text: "Shakleen Ishfar",
              color: Colors.white,
            ),
            currentAccountPicture: CircleAvatar(backgroundColor: Colors.white),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Search'),
            selected: page == Page.HomePage,
            onTap: () {
              if (page != Page.HomePage) {
                Navigator.pushReplacementNamed(
                  context,
                  Page.HomePage.toString(),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.cards),
            title: Text('Saved'),
            selected: page == Page.CardPage,
            onTap: () {
              if (page != Page.CardPage) {
                Navigator.pushReplacementNamed(
                  context,
                  Page.CardPage.toString(),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.trophy),
            title: Text('Quiz'),
            selected: page == Page.QuizPage,
            onTap: () {
              if (page != Page.QuizPage) {
                Navigator.pushReplacementNamed(
                  context,
                  Page.QuizPage.toString(),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(MdiIcons.chartBar),
            title: Text('Stats'),
            selected: page == Page.StatisticsPage,
            onTap: () {
              if (page != Page.StatisticsPage) {
                Navigator.pushReplacementNamed(
                  context,
                  Page.StatisticsPage.toString(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
