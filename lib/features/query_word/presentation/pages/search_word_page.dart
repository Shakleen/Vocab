import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
import 'package:vocab/features/query_word/presentation/bloc/query_word_bloc.dart';
import 'package:vocab/features/query_word/presentation/widgets/widgets_export.dart';
import 'package:vocab/injection_container.dart';

class SearchWordPage extends StatefulWidget {
  SearchWordPage({Key key}) : super(key: key);

  @override
  _SearchWordPageState createState() => _SearchWordPageState();
}

class _SearchWordPageState extends State<SearchWordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Vocab App")),
      body: BlocProvider(
        builder: (BuildContext context) => sl<QueryWordBloc>(),
        child: SearchPageBody(),
      ),
    );
  }
}

class SearchPageBody extends StatefulWidget {
  SearchPageBody({Key key}) : super(key: key);

  @override
  _SearchPageBodyState createState() => _SearchPageBodyState();
}

class _SearchPageBodyState extends State<SearchPageBody> {
  final TextEditingController controller = TextEditingController();
  String _queryWord;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "example",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35.0),
                    ),
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (String value) => _queryWord = value,
                ),
              ),
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: _submit,
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
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

  void _submit() {
    controller.clear();
    BlocProvider.of<QueryWordBloc>(context).add(
      GetWordEntryEvent(queryWord: _queryWord),
    );
  }
}
