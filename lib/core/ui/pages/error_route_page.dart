import 'package:flutter/material.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';

class ErrorRoutePage extends StatelessWidget {
  ErrorRoutePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[Icon(Icons.error)],
      ),
      drawer: SideDrawer(page: Page.HomePage),
      body: Center(
        child: HeadlineText(
          text: 'Error! No such route exists!',
        ),
      ),
    );
  }
}
