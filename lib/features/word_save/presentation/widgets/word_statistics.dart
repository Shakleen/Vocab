import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WordStatistics extends StatelessWidget {
  const WordStatistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: <Widget>[
        // Type of words
        PartOfSpeechStats()
        // General statistics
      ],
    );
  }
}

class PartOfSpeechStats extends StatelessWidget {
  final double totalWords = 20.0;
  final List<double> wordTypeCount = const [8, 10, 14, 15, 13, 10, 6, 12];
  final Map<double, String> partOfSpeechTitles = {
    0: 'Noun',
    1: 'Pronoun',
    2: 'Adjective',
    3: 'Verb',
    4: 'Adverb',
    5: 'Preposition',
    6: 'Conjunction',
    7: 'Interjection',
  };

  PartOfSpeechStats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 12 / 10,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: totalWords,
          borderData: FlBorderData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            leftTitles: const SideTitles(showTitles: false),
            bottomTitles: SideTitles(
              textStyle: TextStyle(
                color: const Color(0xff7589a2),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              showTitles: true,
              margin: 20,
              rotateAngle: 90,
              getTitles: (double value) => partOfSpeechTitles[value],
            ),
          ),
          barGroups: List<BarChartGroupData>.generate(
            wordTypeCount.length,
            (int index) {
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    y: wordTypeCount[index],
                    color: Theme.of(context).primaryColorDark,
                  ),
                ],
                showingTooltipIndicators: [0],
              );
            },
          ),
        ),
      ),
    );
  }
}
