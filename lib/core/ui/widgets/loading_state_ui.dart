import 'package:flutter/material.dart';

class LoadingStateUI extends StatelessWidget {
  const LoadingStateUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
