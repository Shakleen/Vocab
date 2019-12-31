import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/core/ui/widgets/search_bar.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
import 'package:vocab/features/query_word/presentation/bloc/query_word_bloc.dart';
import 'package:vocab/features/query_word/presentation/widgets/widgets_export.dart';

class QueryWordBody extends StatefulWidget {
  QueryWordBody({Key key}) : super(key: key);

  @override
  _QueryWordBodyState createState() => _QueryWordBodyState();
}

class _QueryWordBodyState extends State<QueryWordBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          SearchBar(search: _submit),
          Expanded(
            flex: 1,
            child: BlocBuilder<QueryWordBloc, QueryWordState>(
              builder: (BuildContext context, QueryWordState state) {
                if (state is Empty) {
                  return EmptyStateUI();
                } else if (state is Loading) {
                  return LoadingStateUI();
                } else if (state is Loaded) {
                  return LoadedStateUI(retrieveEntry: state.retrieveEntry);
                } else if (state is Error) {
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
    BlocProvider.of<QueryWordBloc>(context).add(
      GetWordEntryEvent(queryWord: word),
    );
  }
}
