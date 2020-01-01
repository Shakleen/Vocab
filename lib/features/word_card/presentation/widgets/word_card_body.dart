import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/empty_state_ui.dart';
import 'package:vocab/core/ui/widgets/error_state_ui.dart';
import 'package:vocab/core/ui/widgets/loading_state_ui.dart';
import 'package:vocab/core/ui/widgets/search_app_bar.dart';
import 'package:vocab/features/word_card/presentation/widgets/loaded_state_ui.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';

import '../../../../injection_container.dart';

class WordCardBody extends StatelessWidget {
  WordCardBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<WordCardBloc>(),
      child: Scaffold(
        appBar: SearchAppBar<WordCardBloc>(),
        body: BlocBuilder<WordCardBloc, WordCardState>(
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
    );
  }
}
