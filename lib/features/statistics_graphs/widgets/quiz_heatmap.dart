import 'package:flutter/material.dart';
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:provider/provider.dart';
import '../../../core/database/card_database.dart' as db;
import 'level_indicator.dart';

class QuizHeatmap extends StatelessWidget {
  const QuizHeatmap({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future:
            Provider.of<db.CardDatabase>(context).statisticsDao.getActivity(),
        builder:
            (BuildContext context, AsyncSnapshot<Map<DateTime, int>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Activity heatmap",
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  LevelIndicator(
                    low: 50,
                    high: 300,
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
                  HeatMapCalendar(
                    input: snapshot.data,
                    colorThresholds: {
                      200: Colors.green[50],
                      225: Colors.green[100],
                      250: Colors.green[200],
                      275: Colors.green[300],
                      300: Colors.green[300],
                      325: Colors.green[400],
                      350: Colors.green[500],
                      375: Colors.green[600],
                      400: Colors.green[700],
                      425: Colors.green[800],
                      450: Colors.green[900],
                    },
                    weekDaysLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
                    monthsLabels: [
                      "",
                      "Jan",
                      "Feb",
                      "Mar",
                      "Apr",
                      "May",
                      "Jun",
                      "Jul",
                      "Aug",
                      "Sep",
                      "Oct",
                      "Nov",
                      "Dec",
                    ],
                    squareSize: 16.0,
                    textOpacity: 0.3,
                    labelTextColor: Theme.of(context).primaryColorDark,
                    dayTextColor: Theme.of(context).primaryColor,
                    safetyMargin: 0,
                  ),
                ],
              );
            }
          }

          return Center(child: Text("Error occurred!"));
        },
      ),
    );
  }
}
