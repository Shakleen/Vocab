import 'package:flutter/material.dart';
import 'package:vocab/core/ui/widgets/headline_text.dart';
import 'package:vocab/features/word_card/domain/entities/word_card.dart';

class LoadedStateUI extends StatelessWidget {
  final WordCard wordCard;

  const LoadedStateUI({Key key, @required this.wordCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeadlineText(text: wordCard.word),
        ],
      ),
    );
  }
}
