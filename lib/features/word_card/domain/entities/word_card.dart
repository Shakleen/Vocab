import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/domain/entities/pronunciation.dart';
import 'package:vocab/features/word_card/domain/entities/syllable.dart';
import 'package:meta/meta.dart';

import 'word_card_details.dart';

class WordCard extends Equatable {
  final String word;
  final Pronunciation pronunciation;
  final Syllable syllables;
  final List<WordCardDetails> detailList;

  const WordCard({
    @required this.word,
    @required this.pronunciation,
    @required this.syllables,
    @required this.detailList,
  });

  @override
  List<Object> get props => [
        word,
        pronunciation,
        syllables,
        detailList,
      ];
}