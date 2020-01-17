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
  PartOfSpeechType.Verb: 1,
  PartOfSpeechType.Adjective: 2,
  PartOfSpeechType.Noun: 3,
  PartOfSpeechType.Pronoun: 4,
  PartOfSpeechType.Adverb: 5,
  PartOfSpeechType.Preposition: 6,
  PartOfSpeechType.Conjunction: 7,
  PartOfSpeechType.Interjection: 8,
};

const Map<int, PartOfSpeechType> ID_TO_PART_OF_SPEECH_TYPE = const {
  1: PartOfSpeechType.Verb,
  2: PartOfSpeechType.Adjective,
  3: PartOfSpeechType.Noun,
  4: PartOfSpeechType.Pronoun,
  5: PartOfSpeechType.Adverb,
  6: PartOfSpeechType.Preposition,
  7: PartOfSpeechType.Conjunction,
  8: PartOfSpeechType.Interjection,
};

const Map<String, PartOfSpeechType> STRING_TO_PART_OF_SPEECH_TYPE = const {
  'noun': PartOfSpeechType.Noun,
  'pronoun': PartOfSpeechType.Pronoun,
  'verb': PartOfSpeechType.Verb,
  'adjective': PartOfSpeechType.Adjective,
  'adverb': PartOfSpeechType.Adverb,
  'preposition': PartOfSpeechType.Preposition,
  'conjunction': PartOfSpeechType.Conjunction,
  'interjection': PartOfSpeechType.Interjection,
};

String getPartOfSpeechString(PartOfSpeechType type) =>
    type.toString().split('.').last;