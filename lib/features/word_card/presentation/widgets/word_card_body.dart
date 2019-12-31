import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/empty_state_ui.dart';
import 'package:vocab/core/ui/widgets/error_state_ui.dart';
import 'package:vocab/core/ui/widgets/loading_state_ui.dart';
import 'package:vocab/core/ui/widgets/search_bar.dart';
import 'package:vocab/features/word_card/presentation/widgets/loaded_state_ui.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';

class WordCardBody extends StatefulWidget {
  WordCardBody({Key key}) : super(key: key);

  @override
  _QueryWordBodyState createState() => _QueryWordBodyState();
}

class _QueryWordBodyState extends State<WordCardBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SearchBar(search: _submit),
          Expanded(
            flex: 1,
            child: BlocBuilder<WordCardBloc, WordCardState>(
              builder: (BuildContext context, WordCardState state) {
                if (state is EmptyState) {
                  return EmptyStateUI();
                } else if (state is LoadingState) {
                  return LoadingStateUI();
                } else if (state is LoadedState) {
                  return LoadedStateUI(wordCard: state.wordCard);
                } else if (state is ErrorState) {
                  return ErrorStateUI(message: state.message);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _submit(String word) {
    BlocProvider.of<WordCardBloc>(context).add(
      GetWordCardEvent(queryWord: word),
    );
  }
}
