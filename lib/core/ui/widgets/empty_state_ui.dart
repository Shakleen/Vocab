import 'package:flutter/material.dart';

class EmptyStateUI extends StatelessWidget {
  final String text;

  const EmptyStateUI({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.display1.copyWith(
                color: Colors.grey[300],
              ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
