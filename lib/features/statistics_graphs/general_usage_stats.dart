import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart' as db;
import 'package:provider/provider.dart';

class GeneralUsageStats extends StatelessWidget {
  final Map<double, String> statTitles = {
    0: 'Search',
    1: 'Saved',
    2: 'Quizzed',
    3: 'Editted',
    4: 'Deleted',
  };
  final Map<double, Color> stateBarColors = {
    0: Colors.blue,
    1: Colors.red,
    2: Colors.yellow,
    3: Colors.green,
    4: Colors.purple,
  };

  GeneralUsageStats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 12 / 10,
      child: FutureBuilder(
        future: Provider.of<db.CardDatabase>(context)
            .statisticsDao
            .getGeneralUsageStats(DateTime.now()),
        builder:
            (BuildContext context, AsyncSnapshot<db.UsageInfoData> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final List<int> values = [
                snapshot.data.wordsSearched,
                snapshot.data.wordsSaved,
                snapshot.data.cardsQuizzed,
                snapshot.data.wordsEdited,
                snapshot.data.cardsDeleted,
              ];

              return Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: AspectRatio(
                  aspectRatio: 12 / 10,
                  child: BarChart(
                    BarChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        drawHorizontalLine: true,
                        verticalInterval: 10,
                      ),
                      axisTitleData: FlAxisTitleData(
                        show: true,
                        topTitle: AxisTitle(
                          showTitle: true,
                          titleText: "Usage stats",
                          textAlign: TextAlign.center,
                          textStyle: Theme.of(context).textTheme.headline
                        )
                      ),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: _max(values) + 10,
                      borderData: FlBorderData(show: false),
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
                          getTitles: (double value) => statTitles[value],
                        ),
                      ),
                      barGroups: List<BarChartGroupData>.generate(
                        values.length,
                        (int index) {
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                y: values[index].toDouble(),
                                color: stateBarColors[index],
                              ),
                            ],
                            showingTooltipIndicators: [0],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
          }

          return Container(child: Text("No info available for this date"));
        },
      ),
    );
  }

  double _max(List list) {
    int maxVal = -1;

    list.forEach((val) => maxVal = max(maxVal, val));

    return maxVal.toDouble();
  }
}
