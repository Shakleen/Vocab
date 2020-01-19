import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/empty_state_ui.dart';
import 'package:vocab/core/ui/widgets/error_state_ui.dart';
import 'package:vocab/features/word_save/domain/entity/word_details_summary.dart';
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
  final List<WordDetailsSummary> _wordList = [];
  WordListBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<WordListBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _wordList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordListBloc, WordListBlocState>(
      builder: (BuildContext context, WordListBlocState state) {
        if (state is InitialWordListBlocState) {
          _bloc.add(GetWordListEvent(limit: 10));
          return EmptyStateUI(text: "Loading saved words!");
        } else if (state is ErrorWordListBlocState) {
          return ErrorStateUI(message: state.errorMessage);
        } else if (state is LoadedWordListBlocState) {
          print("Words fetched = ${state.wordList.length}");
          if (_bloc.endReached == false) {
            _wordList.addAll(state.wordList);
          }
          if (_wordList.isEmpty) {
            return EmptyStateUI(text: "No saved words!");
          }
        }

        return NotificationListener<ScrollNotification>(
          onNotification: _handleNotification,
          child: ListView.builder(
            padding: const EdgeInsets.all(4.0),
            controller: _controller,
            itemCount: _wordList.length,
            itemBuilder: (BuildContext context, int index) {
              return WordTile(wordSummary: _wordList[index]);
            },
          ),
        );
      },
    );
  }

  bool _handleNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _controller.position.extentAfter == 0 &&
        _bloc.endReached == false) {
      _bloc.add(GetWordListEvent(limit: 10));
    }

    return false;
  }
}
