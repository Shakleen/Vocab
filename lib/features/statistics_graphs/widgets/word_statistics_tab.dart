import 'package:flutter/material.dart';
import 'package:vocab/features/statistics_graphs/widgets/general_usage_graph.dart';
import 'package:vocab/features/statistics_graphs/widgets/part_of_speech_stats.dart';

class WordStatisticsTab extends StatelessWidget {
  const WordStatisticsTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[PartOfSpeechStats(), GeneralUsageGraph()],
    );
  }
}
