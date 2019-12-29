import 'package:equatable/equatable.dart';

enum WordSearchResultKeyNames { word, results, syllables, pronunciation, frequency }

class WordSearchResult extends Equatable {
  final String word;
  final List<WordDetails> results;
  final Syllable syllables;
  final Pronunciation pronunciation;
  final double frequency;

  WordSearchResult({
    this.word,
    this.results,
    this.syllables,
    this.pronunciation,
    this.frequency,
  });

  @override
  List<Object> get props =>
      [word, results, syllables, pronunciation, frequency];
}
