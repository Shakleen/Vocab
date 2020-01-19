import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/empty_state_ui.dart';
import 'package:vocab/core/ui/widgets/error_state_ui.dart';
import 'package:vocab/core/ui/widgets/loading_state_ui.dart';
import 'package:vocab/features/word_card/presentation/widgets/loaded_state_ui.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';

class WordCardBody extends StatelessWidget {
  WordCardBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WordCardBloc, WordCardState>(
        builder: (BuildContext context, WordCardState state) {
          if (state is EmptyWordCardState) {
            return EmptyStateUI(text: "Start by searching for a word!");
          } else if (state is LoadingWordCardState) {
            return LoadingStateUI();
          } else if (state is LoadedWordCardState) {
            return LoadedStateUI(wordCard: state.wordCard);
          } else if (state is ErrorWordCardState) {
            return ErrorStateUI(message: state.message);
          }
        },
      );
}
