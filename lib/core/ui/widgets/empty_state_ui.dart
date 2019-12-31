import 'package:flutter/material.dart';

class EmptyStateUI extends StatelessWidget {
  const EmptyStateUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Start by searching for a word!")),
    );
  }
}
