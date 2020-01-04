import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/pages/base_page.dart';
import 'core/ui/pages/card_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(Vocab());
}

class Vocab extends StatelessWidget {
  const Vocab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue),
      home: BasePage(),
      routes: {
        Page.HomePage.toString() : (BuildContext context) => BasePage(),
        Page.CardPage.toString() : (BuildContext context) => CardPage(),
      },
    );
  }
}
