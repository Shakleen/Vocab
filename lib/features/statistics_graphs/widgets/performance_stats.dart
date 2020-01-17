import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vocab/core/database/card_database.dart' as db;
import 'package:provider/provider.dart';
import 'package:vocab/core/entities/performance_result.dart';
import 'package:vocab/core/util/formatter.dart';

class PerformanceStats extends StatelessWidget {
  final int range;

  PerformanceStats({Key key, @required this.range}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 12 / 10,
      child: FutureBuilder(
        future: Provider.of<db.CardDatabase>(context)
            .statisticsDao
            .getPerformanceResults(
              DateTime.now().subtract(Duration(days: range - 1)),
              DateTime.now(),
            ),
        builder: (BuildContext context,
            AsyncSnapshot<Map<DateTime, PerformaceResult>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AspectRatio(
                  aspectRatio: 12 / 10,
                  child: BarChart(
                    BarChartData(
                      axisTitleData: FlAxisTitleData(
                          show: true,
                          topTitle: AxisTitle(
                            showTitle: true,
                            titleText: "Performance graph for last $range days",
                            textAlign: TextAlign.center,
                            textStyle: Theme.of(context).textTheme.title,
                            margin: 16,
                          )),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 200.0,
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: const SideTitles(showTitles: false),
                        bottomTitles: SideTitles(
                          textStyle: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          showTitles: true,
                          margin: 20,
                          getTitles: (double value) => value.toString(),
                        ),
                      ),
                      barGroups: List<BarChartGroupData>.generate(
                        range,
                        (int index) {
                          final DateTime indexDay = _getPastDate(index);
                          final PerformaceResult result =
                              snapshot.data[indexDay] == null
                                  ? PerformaceResult()
                                  : snapshot.data[indexDay];

                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                y: result.totalCorrect.toDouble(),
                                color: Colors.green,
                                width: 8,
                                isRound: false,
                              ),
                              BarChartRodData(
                                y: result.totalWrong.toDouble(),
                                color: Colors.green,
                                width: 8,
                                isRound: false,
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

  DateTime _getPastDate(int index) =>
      DateTime.now().subtract(Duration(days: index));

  double _max(List<int> list) {
    int maxVal = -1;

    list.forEach((int val) {
      maxVal = max(maxVal, val == null ? 0 : val);
    });

    return maxVal.toDouble();
  }
}
