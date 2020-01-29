import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/core/enums/mastery_levels.dart';
import '../../../core/database/card_database.dart' as db;
import 'indicator.dart';

class MasteryLevelStats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MasteryLevelStatsState();
}

class MasteryLevelStatsState extends State {
  final List<String> _masteryName = [];
  final List<Color> _masteryColor = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; ++i) {
      _masteryName.add(getMasteryLevelString(ID_TO_MASTERY_LEVEL[i]));
    }

    _masteryColor.addAll([Colors.grey, Colors.yellow, Colors.lightGreen, Colors.green]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<db.CardDatabase>(context)
          .statisticsDao
          .getCardLevelStatistics(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: 1.2,
              child: Card(
                margin: const EdgeInsets.all(8.0),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Mastery level stats",
                      style: Theme.of(context).textTheme.title,
                    ),
                    Row(
                      children: <Widget>[
                        const SizedBox(height: 18),
                        Expanded(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: PieChart(
                              PieChartData(
                                borderData: FlBorderData(show: false),
                                sectionsSpace: 0,
                                centerSpaceRadius: 40,
                                sections: _showingSections(snapshot.data),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List<Widget>.generate(
                            3,
                            _generateIndicator,
                          ),
                        ),
                        const SizedBox(width: 28),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }

        return Center(child: Text("Error occured!"));
      },
    );
  }

  List<PieChartSectionData> _showingSections(Map<MasteryLevels, int> data) =>
      List<PieChartSectionData>.generate(3, (int index) {
        int val = data[ID_TO_MASTERY_LEVEL[index]];
        if (val == null) val = 0;
        return PieChartSectionData(
          color: _masteryColor[index],
          value: val.toDouble(),
          title: val.toString(),
          radius: 50,
          titleStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      });

  Widget _generateIndicator(int index) => Padding(
        padding: const EdgeInsets.only(bottom: 4.0, left: 4.0),
        child: Indicator(
          color: _masteryColor[index],
          text: _masteryName[index],
          isSquare: true,
        ),
      );
}
