import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/ui/widgets/word_info_widget.dart';

class LoadedStateUI extends StatelessWidget {
  final WordCard wordCard;

  const LoadedStateUI({Key key, @required this.wordCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WordInfoWidget(wordCard: wordCard);
  }
}
