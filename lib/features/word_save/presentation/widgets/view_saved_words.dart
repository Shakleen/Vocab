import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/empty_state_ui.dart';
import 'package:vocab/core/ui/widgets/error_state_ui.dart';
import 'package:vocab/core/ui/widgets/loading_state_ui.dart';
import 'package:vocab/features/word_save/presentation/bloc/bloc.dart';
import 'package:provider/provider.dart';

import 'word_tile.dart';

class ViewSavedWords extends StatefulWidget {
  ViewSavedWords({Key key}) : super(key: key);

  @override
  _ViewSavedWordsState createState() => _ViewSavedWordsState();
}

class _ViewSavedWordsState extends State<ViewSavedWords> {
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WordListBloc, WordListBlocState>(
        builder: (BuildContext context, WordListBlocState state) {
          if (state is InitialWordListBlocState) {
            Provider.of<WordListBloc>(context).add(GetWordListEvent(limit: 10));
            return EmptyStateUI();
          } else if (state is LoadingWordListBlocState) {
            return LoadingStateUI();
          } else if (state is LoadedWordListBlocState) {
            return NotificationListener<ScrollNotification>(
              onNotification: _handleNotification,
              child: ListView.builder(
                padding: const EdgeInsets.all(4.0),
                controller: _controller,
                itemCount: state.wordList.length,
                itemBuilder: (BuildContext context, int index) {
                  return WordTile(wordSummary: state.wordList[index]);
                },
              ),
            );
          } else if (state is ErrorWordListBlocState) {
            return ErrorStateUI(message: state.errorMessage);
          }
        },
      );

  bool _handleNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _controller.position.extentAfter == 0) {
      Provider.of<WordListBloc>(context).add(GetWordListEvent(limit: 10));
    }

    return false;
  }
}
