import 'package:flutter/material.dart';
import 'package:vocab/features/statistics_graphs/widgets/mastery_level_stat.dart';
import 'package:vocab/features/statistics_graphs/widgets/quiz_heatmap.dart';

class QuizStatisticsTab extends StatelessWidget {
  const QuizStatisticsTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MasteryLevelStats(),
        QuizHeatmap(),
      ],
    );
  }
}