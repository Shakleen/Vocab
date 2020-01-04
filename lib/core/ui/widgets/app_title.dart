import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        '🅥🅞🅒🅐🅑',
        style: Theme.of(context).textTheme.display1.copyWith(
              color: Colors.white,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
