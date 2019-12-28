import 'package:flutter/material.dart';

class ErrorStateUI extends StatelessWidget {
  final String message;

  const ErrorStateUI({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(message));
  }
}
