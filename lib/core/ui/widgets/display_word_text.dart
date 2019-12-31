import 'package:flutter/material.dart';

class DisplayWordText extends StatelessWidget {
  final String text;

  const DisplayWordText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '"$text"',
      style: Theme.of(context).textTheme.display2.copyWith(
            color: Theme.of(context).accentColor,
          ),
      textAlign: TextAlign.center,
    );
  }
}
