import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/title_text.dart';

class TitleAndWordList extends StatelessWidget {
  final String title;
  final List<String> wordList;

  const TitleAndWordList({
    Key key,
    @required this.title,
    @required this.wordList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [TitleText(text: title)];
    children.addAll(
      List<Widget>.generate(
        wordList.length,
        (int index) => Text('${index+1}. ${wordList[index]}'),
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
    );
  }
}