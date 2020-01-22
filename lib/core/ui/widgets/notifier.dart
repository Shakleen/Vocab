import 'package:flutter/material.dart';

class Notifier extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;

  const Notifier({
    Key key,
    @required this.text,
    @required this.color,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline,
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: CircleAvatar(
            backgroundColor: color,
            radius: 60,
            child: IconButton(
              iconSize: 100,
              icon: Icon(icon, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}