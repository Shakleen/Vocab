import 'package:flutter/material.dart';

class EmptyStateUI extends StatelessWidget {
  const EmptyStateUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Start by searching for a word!",
          style: Theme.of(context).textTheme.display1.copyWith(
            color: Colors.grey[300],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
