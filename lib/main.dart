import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vocab/core/ui/pages/search_word_page.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
import 'package:vocab/features/query_word/presentation/widgets/query_word_body.dart';

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
      home: SearchWordPage<QueryWordBloc>(body: QueryWordBody()),
    );
  }
}
