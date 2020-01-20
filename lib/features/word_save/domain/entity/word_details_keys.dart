enum WordDetailKeys {
  definition,
  pronunciation,
  senses,
  examples,
  synonyms,
  antonyms,
  partOfSpeech,
  syllables,
  senseID,
  id,
  word,
}

String getWordDetailKeyString(WordDetailKeys key) =>
    key.toString().split('.').last;
