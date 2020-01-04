import 'package:flutter/material.dart';

class HeadlineText extends StatelessWidget {
  final String text;
  final Color color;

  const HeadlineText({Key key, this.color, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline.copyWith(
            color: color != null ? color : Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
