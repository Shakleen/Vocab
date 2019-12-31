import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String text;

  const HeadlineText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline.copyWith(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
