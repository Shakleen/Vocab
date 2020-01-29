import 'package:flutter/material.dart';

import 'performance_stats.dart';

class PerformanceGraph extends StatefulWidget {
  PerformanceGraph({Key key}) : super(key: key);

  @override
  _PerformanceGraphState createState() => _PerformanceGraphState();
}

class _PerformanceGraphState extends State<PerformanceGraph> {
  int _range;

  @override
  void initState() {
    super.initState();
    _range = 15;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              PerformanceStats(range: _range),
              SizedBox(height: 4),
              ButtonBar(
                buttonTextTheme: ButtonTextTheme.primary,
                alignment: MainAxisAlignment.spaceAround,
                buttonHeight: 50,
                buttonMinWidth: 100,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Last 7 days", textAlign: TextAlign.center),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      setState(() {
                        _range = 7;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("Last 15 days", textAlign: TextAlign.center),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      setState(() {
                        _range = 15;
                      });
                    },
                  ),
                  RaisedButton(
                    child: Text("Last 31 days", textAlign: TextAlign.center),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      setState(() {
                        _range = 31;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
