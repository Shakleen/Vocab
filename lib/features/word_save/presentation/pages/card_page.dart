import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/navigation/routes.dart';
import 'package:vocab/core/ui/widgets/app_title.dart';
import 'package:vocab/core/ui/widgets/side_drawer.dart';
import 'package:vocab/features/word_save/presentation/bloc/bloc.dart';
import 'package:vocab/features/word_save/presentation/widgets/view_saved_words.dart';
import 'package:vocab/injection_container.dart';

class CardPage extends StatelessWidget {
  CardPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppTitle(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add new word entry',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '${Page.CardFormPage}',
                arguments: {
                  'isEditing': false,
                },
              );
            },
          ),
        ],
      ),
      drawer: SideDrawer(page: Page.CardPage),
      body: BlocProvider<WordListBloc>(create: sl(), child: ViewSavedWords()),
    );
  }
}
