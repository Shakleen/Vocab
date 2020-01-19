import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/empty_state_ui.dart';
import 'package:vocab/core/ui/widgets/error_state_ui.dart';
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
  WordListBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<WordListBloc>(context);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WordListBloc, WordListBlocState>(
        builder: (BuildContext context, WordListBlocState state) {
          if (state is InitialWordListBlocState) {
            _bloc.add(GetWordListEvent(limit: 10));
            return EmptyStateUI(text: "Loading saved words!");
          } else if (state is LoadedWordListBlocState) {
            if (state.wordList.isEmpty) {
              return EmptyStateUI(text: "No saved words!");
            } else {
              _removeSnackBar();
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
            }
          } else if (state is ErrorWordListBlocState) {
            return ErrorStateUI(message: state.errorMessage);
          }
        },
      );

  bool _handleNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _controller.position.extentAfter == 0 &&
        _bloc.hasReachedEnd == false) {
      _showSnackBar();
      _bloc.add(GetWordListEvent(limit: 10));
    }

    return false;
  }

  void _showSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Center(child: CircularProgressIndicator()),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  void _removeSnackBar() {
    Scaffold.of(context).removeCurrentSnackBar();
  }
}
