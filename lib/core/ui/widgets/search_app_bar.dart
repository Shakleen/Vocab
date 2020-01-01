import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';

import 'search_bar.dart';

class SearchAppBar<T extends Bloc> extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchAppBar({Key key}) : super(key: key);

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
            Container(
              child: Text(
                '🅥🅞🅒🅐🅑',
                style: Theme.of(context).textTheme.display1.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
            SearchBar<T>(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(91);
}
