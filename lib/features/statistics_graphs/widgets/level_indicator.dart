import 'package:flutter/material.dart';

class LevelIndicator extends StatelessWidget {
  final List<Color> colorList;
  final int low, high;

  const LevelIndicator({
    Key key,
    this.colorList,
    this.low,
    this.high,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$low', style: Theme.of(context).textTheme.subtitle),
          ),
          Expanded(
            child: Container(
              height: 25,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: colorList),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$high+', style: Theme.of(context).textTheme.subtitle),
          ),
        ],
      ),
    );
  }
}
