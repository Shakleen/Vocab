import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:vocab/core/enums/part_of_speech.dart';
import 'package:provider/provider.dart';
import '../../core/database/card_database.dart' as db;
import 'indicator.dart';

class PartOfSpeechStats extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PartOfSpeechStatsState();
}

class PartOfSpeechStatsState extends State {
  final List<String> _posNames;
  final List<Color> _posColors;

  PartOfSpeechStatsState()
      : _posNames = List.generate(
          8,
          (i) => getPartOfSpeechString(ID_TO_PART_OF_SPEECH_TYPE[i+1]),
        ),
        _posColors = [
          Color(0xffe74c3c),
          Color(0xffe67e22),
          Color(0xfff1c40f),
          Color(0xff2ecc71),
          Color(0xff1abc9c),
          Color(0xff3498db),
          Color(0xff9b59b6),
          Color(0xff34495e),
        ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<db.CardDatabase>(context)
          .statisticsDao
          .getPartOfSpeechStatistics(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return AspectRatio(
              aspectRatio: 1.2,
              child: Card(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Part of speech stat",
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
                            8,
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

  List<PieChartSectionData> _showingSections(Map<PartOfSpeechType, int> data) =>
      List<PieChartSectionData>.generate(8, (int index) {
        int val = data[ID_TO_PART_OF_SPEECH_TYPE[index + 1]];
        if (val == null) val = 0;
        return PieChartSectionData(
          color: _posColors[index],
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
          color: _posColors[index],
          text: _posNames[index],
          isSquare: true,
        ),
      );
}
