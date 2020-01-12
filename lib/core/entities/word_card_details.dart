import 'package:equatable/equatable.dart';

enum PartOfSpeechType {
  Noun,
  Pronoun,
  Verb,
  Adjective,
  Adverb,
  Preposition,
  Conjunction,
  Interjection,
}

const Map<PartOfSpeechType, int> PART_OF_SPEECH_TYPE_TO_ID = const {
  PartOfSpeechType.Noun: 1,
  PartOfSpeechType.Pronoun: 2,
  PartOfSpeechType.Verb: 3,
  PartOfSpeechType.Adjective: 4,
  PartOfSpeechType.Adverb: 5,
  PartOfSpeechType.Preposition: 6,
  PartOfSpeechType.Conjunction: 7,
  PartOfSpeechType.Interjection: 8,
};

const Map<int, PartOfSpeechType> ID_TO_PART_OF_SPEECH_TYPE = const {
  1: PartOfSpeechType.Noun,
  2: PartOfSpeechType.Pronoun,
  3: PartOfSpeechType.Verb,
  4: PartOfSpeechType.Adjective,
  5: PartOfSpeechType.Adverb,
  6: PartOfSpeechType.Preposition,
  7: PartOfSpeechType.Conjunction,
  8: PartOfSpeechType.Interjection,
};

String getPartOfSpeechString(PartOfSpeechType type) =>
    type.toString().split('.').last;

class WordCardDetails extends Equatable {
  final String definition;
  final PartOfSpeechType partOfSpeech;
  final List<String> synonymList;
  final List<String> exampleList;
  final List<String> antonymList;

  WordCardDetails({
    this.definition,
    this.partOfSpeech,
    this.synonymList,
    this.exampleList,
    this.antonymList,
  });

  @override
  List<Object> get props => [
        definition,
        partOfSpeech,
        exampleList,
        synonymList,
        antonymList,
      ];
}
