enum AttributeType {
  Spelling,
  Pronunciation,
  Syllables,
  Example,
  Definition,
  Synonyms,
  Antonyms,
  PartOfSpeech,
}

const Map<AttributeType, int> ATTRIBUTE_TYPE_TO_ID = const {
  AttributeType.Spelling: 1,
  AttributeType.Pronunciation: 2,
  AttributeType.Syllables: 3,
  AttributeType.Example: 4,
  AttributeType.Definition: 5,
  AttributeType.Synonyms: 6,
  AttributeType.Antonyms: 7,
  AttributeType.PartOfSpeech: 8,
};

const Map<int, AttributeType> ID_TO_ATTRIBUTE_TYPE = const {
  1: AttributeType.Spelling,
  2: AttributeType.Pronunciation,
  3: AttributeType.Syllables,
  4: AttributeType.Example,
  5: AttributeType.Definition,
  6: AttributeType.Synonyms,
  7: AttributeType.Antonyms,
  8: AttributeType.PartOfSpeech,
};