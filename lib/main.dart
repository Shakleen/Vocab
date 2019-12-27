import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'features/query_word/presentation/pages/search_word_page.dart';
import 'injection_container.dart' as di;

void main() {
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
      home: SearchWordPage(),
    );
  }
}
