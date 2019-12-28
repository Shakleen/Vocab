import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

class LoadedStateUI extends StatelessWidget {
  final RetrieveEntry retrieveEntry;

  const LoadedStateUI({Key key, @required this.retrieveEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(retrieveEntry.word));
  }
}
