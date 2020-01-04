import 'package:flutter/material.dart';

import 'app_title.dart';
import 'search_bar.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TabBar tabBar;
  const SearchAppBar({Key key, @required this.tabBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      elevation: 2,
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppTitle(),
            SearchBar(),
            tabBar,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(165);
}
