import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/empty_state_ui.dart';
import 'package:vocab/core/ui/widgets/error_state_ui.dart';
import 'package:vocab/core/ui/widgets/loading_state_ui.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
import 'package:vocab/features/query_word/presentation/bloc/query_word_bloc.dart';
import 'package:vocab/features/query_word/presentation/widgets/loaded_state_ui.dart';

class QueryWordBody extends StatelessWidget {
  QueryWordBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<QueryWordBloc, QueryWordState>(
        builder: (BuildContext context, QueryWordState state) {
          if (state is EmptyQueryWordState) {
            return EmptyStateUI(text: "Start by searching for a word!");
          } else if (state is LoadingQueryWordState) {
            return LoadingStateUI();
          } else if (state is LoadedQueryWordState) {
            return LoadedStateUI(retrieveEntry: state.retrieveEntry);
          } else if (state is ErrorQueryWordState) {
            return ErrorStateUI(message: state.message);
          }
        },
      );
}
