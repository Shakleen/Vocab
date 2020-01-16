import 'package:flutter/material.dart';
import 'package:vocab/core/util/formatter.dart';

import 'general_usage_stats.dart';

class GeneralUsageGraph extends StatefulWidget {
  GeneralUsageGraph({Key key}) : super(key: key);

  @override
  _GeneralUsageGraphState createState() => _GeneralUsageGraphState();
}

class _GeneralUsageGraphState extends State<GeneralUsageGraph> {
  DateTime _viewTime;

  @override
  void initState() {
    super.initState();
    _viewTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GeneralUsageStats(graphTime: _viewTime),
          ButtonBar(
            buttonTextTheme: ButtonTextTheme.primary,
            alignment: MainAxisAlignment.spaceAround,
            buttonHeight: 50,
            buttonMinWidth: 150,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "Previous day\n<<",
                  textAlign: TextAlign.center,
                ),
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _viewTime = _viewTime.subtract(Duration(days: 1));
                  });
                },
              ),
              RaisedButton(
                child: Text(
                  "Next day\n>>",
                  textAlign: TextAlign.center,
                ),
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _viewTime = _viewTime.add(Duration(days: 1));
                  });
                },
              ),
            ],
          )
        ],
      ),
      )
    );
  }
}
