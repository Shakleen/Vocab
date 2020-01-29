import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/database/card_database.dart' as db;
import 'package:vocab/core/entities/performance_result.dart';
import 'package:vocab/core/util/formatter.dart';

import 'indicator.dart';
import 'level_indicator.dart';

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
                      aspectRatio: 12 / 9,
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
                                  getShortFormattedDateTIme(_getPastDate(
                                      (range - value - 1).toInt())),
                            ),
                          ),
                          barGroups: List<BarChartGroupData>.generate(
                            range,
                            (int index) {
                              final DateTime indexDay =
                                  _getPastDate(range - index - 1);
                              final PerformaceResult result =
                                  snapshot.data.performanceMap[indexDay] == null
                                      ? PerformaceResult()
                                      : snapshot.data.performanceMap[indexDay];
                              return BarChartGroupData(
                                x: index,
                                barsSpace: 0,
                                barRods: [
                                  BarChartRodData(
                                    y: result.totalCorrect.toDouble(),
                                    color:
                                        _getCorrectColor(result.totalCorrect),
                                    width: _getWidth(),
                                    isRound: false,
                                  ),
                                  BarChartRodData(
                                    y: result.totalWrong.toDouble(),
                                    color: _getWrongColor(result.totalWrong),
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
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            LevelIndicator(
                              low: 200,
                              high: 450,
                              colorList: <Color>[
                                Colors.green[50],
                                Colors.green[100],
                                Colors.green[200],
                                Colors.green[300],
                                Colors.green[300],
                                Colors.green[400],
                                Colors.green[500],
                                Colors.green[600],
                                Colors.green[700],
                                Colors.green[800],
                                Colors.green[900],
                              ],
                            ),
                            Text(
                              "Correct",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            LevelIndicator(
                              low: 5,
                              high: 55,
                              colorList: <Color>[
                                Colors.red[50],
                                Colors.red[100],
                                Colors.red[200],
                                Colors.red[300],
                                Colors.red[300],
                                Colors.red[400],
                                Colors.red[500],
                                Colors.red[600],
                                Colors.red[700],
                                Colors.red[800],
                                Colors.red[900],
                              ],
                            ),
                            Text(
                              "Wrong",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
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
    if (range == 7)
      return 27.5;
    else if (range == 15)
      return 13.0;
    else if (range == 31) return 6.0;
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

  Color _getCorrectColor(int value) {
    if (value <= 200) return Colors.green[50];
    if (value <= 225) return Colors.green[100];
    if (value <= 250) return Colors.green[200];
    if (value <= 275) return Colors.green[300];
    if (value <= 300) return Colors.green[300];
    if (value <= 325) return Colors.green[400];
    if (value <= 350) return Colors.green[500];
    if (value <= 375) return Colors.green[600];
    if (value <= 400) return Colors.green[700];
    if (value <= 425) return Colors.green[800];
    if (value <= 450) return Colors.green[900];
  }

  Color _getWrongColor(int value) {
    if (value <= 5) return Colors.red[50];
    if (value <= 10) return Colors.red[100];
    if (value <= 15) return Colors.red[200];
    if (value <= 20) return Colors.red[300];
    if (value <= 25) return Colors.red[300];
    if (value <= 30) return Colors.red[400];
    if (value <= 35) return Colors.red[500];
    if (value <= 40) return Colors.red[600];
    if (value <= 45) return Colors.red[700];
    if (value <= 50) return Colors.red[800];
    if (value <= 55) return Colors.red[900];
  }
}
