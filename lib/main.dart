import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocab/core/navigation/routes.dart';
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
      initialRoute: '${Page.HomePage}',
      onGenerateRoute: generateRoute,
    );
  }
}
