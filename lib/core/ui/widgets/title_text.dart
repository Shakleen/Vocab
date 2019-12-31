import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;

  const TitleText({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title.copyWith(
              color: Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
