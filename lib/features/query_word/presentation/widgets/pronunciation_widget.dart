import 'package:flutter/material.dart';
import 'package:vocab/features/query_word/domain/entities/pronunciation.dart';

class PronunciationWidget extends StatelessWidget {
  final int index;
  final Pronunciation pronunciation;

  const PronunciationWidget({
    Key key,
    @required this.index,
    @required this.pronunciation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Theme.of(context).textTheme.title;
    final TextStyle subtitleStyle = Theme.of(context).textTheme.subtitle;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('Pronunciation #${index}', style: titleStyle),
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {
                  // lexicalEntry.pronunciationList
                  // TODO: Pronunciation playing
                },
              )
            ],
          ),
          Text('Dialect(s)', style: subtitleStyle),
          Column(children: List.from(pronunciation.dialectList.map(_toText))),
          Text('Phonetic Notation: ${pronunciation.phoneticNotation}',
              style: subtitleStyle),
          Text('Phonetic Spelling: ${pronunciation.phoneticSpelling}',
              style: subtitleStyle),
        ],
      ),
    );
  }

  Text _toText(String e) => Text(e);
}
