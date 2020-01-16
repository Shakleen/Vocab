import 'package:flutter/material.dart';
import 'package:vocab/features/statistics_graphs/general_usage_graph.dart';

class WordStatistics extends StatelessWidget {
  const WordStatistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        // Type of words
        // PartOfSpeechStats(),
        // General statistics
        GeneralUsageGraph(),
      ],
    );
  }
}
