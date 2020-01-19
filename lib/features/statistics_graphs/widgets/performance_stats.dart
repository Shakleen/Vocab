import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/database/card_database.dart' as db;
import 'package:vocab/core/entities/performance_result.dart';
import 'package:vocab/core/util/formatter.dart';

import 'indicator.dart';

class PerformanceStats extends StatelessWidget {
  final int range;
  final Color _correct_color = Colors.green, _wrong_color = Colors.red;

  PerformanceStats({Key key, @required this.range}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: FutureBuilder(
        future: Provider.of<db.CardDatabase>(context)
            .statisticsDao
            .getPerformanceResults(range),
        builder: (BuildContext context, AsyncSnapshot<Performance> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: AspectRatio(
                      aspectRatio: 12 / 10,
                      child: BarChart(
                        BarChartData(
                          axisTitleData: FlAxisTitleData(
                            show: true,
                            topTitle: AxisTitle(
                              showTitle: true,
                              titleText:
                                  "Performance graph for last $range days",
                              textAlign: TextAlign.center,
                              textStyle: Theme.of(context).textTheme.title,
                              margin: 16,
                            ),
                          ),
                          alignment: BarChartAlignment.spaceAround,
                          maxY: snapshot.data.maxValue.toDouble(),
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
                              rotateAngle: 90,
                              getTitles: (double value) =>
                                  getShortFormattedDateTIme(
                                      _getPastDate(value.toInt())),
                            ),
                          ),
                          barGroups: List<BarChartGroupData>.generate(
                            range,
                            (int index) {
                              final DateTime indexDay = _getPastDate(index);
                              final PerformaceResult result =
                                  snapshot.data.performanceMap[indexDay] == null
                                      ? PerformaceResult()
                                      : snapshot.data.performanceMap[indexDay];
                              print(result.totalCorrect);
                              print(result.totalWrong);
                              return BarChartGroupData(
                                x: index,
                                barsSpace: 0,
                                barRods: [
                                  BarChartRodData(
                                    y: result.totalCorrect.toDouble(),
                                    color: _correct_color,
                                    width: _getWidth(),
                                    isRound: false,
                                  ),
                                  BarChartRodData(
                                    y: result.totalWrong.toDouble(),
                                    color: _wrong_color,
                                    width: _getWidth(),
                                    isRound: false,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 4.0),
                        child: Indicator(
                          color: _correct_color,
                          text: 'Correct',
                          isSquare: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0, left: 4.0),
                        child: Indicator(
                          color: _wrong_color,
                          text: 'Wrong',
                          isSquare: true,
                        ),
                      )
                    ],
                  ),
                ],
              );
            }
          }

          return Container(child: Text("No info available for this date"));
        },
      ),
    );
  }

  double _getWidth() {
    if (range == 3)
      return 64.5;
    else if (range == 7)
      return 27.5;
    else if (range == 14) return 13.5;
  }

  DateTime _getPastDate(int index) => DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        0,
        0,
        0,
        0,
        0,
      ).subtract(Duration(days: index));
}
