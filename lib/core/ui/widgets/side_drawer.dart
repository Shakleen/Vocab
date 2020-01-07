import 'package:flutter/material.dart';
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
            title: Text('Home Page'),
            selected: page == Page.HomePage,
            onTap: () {
              if (page != Page.HomePage) {
                Navigator.pushReplacementNamed(
                    context, Page.HomePage.toString());
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Card Page'),
            selected: page == Page.CardPage,
            onTap: () {
              if (page != Page.CardPage) {
                Navigator.pushReplacementNamed(
                    context, Page.CardPage.toString());
              }
            },
          ),
        ],
      ),
    );
  }
}
