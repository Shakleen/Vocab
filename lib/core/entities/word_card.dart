import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'pronunciation.dart';
import 'syllable.dart';
import 'word_card_details.dart';

class WordCard extends Equatable {
  final int id;
  final String word;
  final Pronunciation pronunciation;
  final Syllable syllables;
  final List<WordCardDetails> detailList;

  const WordCard({
    this.id,
    @required this.word,
    @required this.pronunciation,
    @required this.syllables,
    @required this.detailList,
  });

  @override
  List<Object> get props => [
        id,
        word,
        pronunciation,
        syllables,
        detailList,
      ];
}
