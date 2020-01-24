part of 'package:vocab/core/database/card_database.dart';

@UseDao(tables: [
  Entries,
  Senses,
  Words,
  Examples,
  Syllables,
  ThesaurusList,
  ExampleList,
  SyllableList,
  UsageInfo,
])
class WordDao extends DatabaseAccessor<CardDatabase> with _$WordDaoMixin {
  final CardDatabase cardDatabase;

  WordDao(this.cardDatabase) : super(cardDatabase);

  Future<UsageInfoData> _getUsageInformation() => (select(usageInfo)
        ..where((table) => table.date.equals(_getOnlyTimeToday())))
      .getSingle();

  Future handleWordsSearchUsageInfo() async {
    final UsageInfoData dbUsageInfoData = await _getUsageInformation();

    if (dbUsageInfoData == null) {
      await into(usageInfo)
          .insert(UsageInfoData(wordsSearched: 1, date: _getOnlyTimeToday()));
    } else {
      await (update(usageInfo)
            ..where((table) => table.date.equals(dbUsageInfoData.date)))
          .write(
        UsageInfoData(wordsSearched: dbUsageInfoData.wordsSearched + 1),
      );
    }
  }

  Future<Word> _getWordFromString(String inputWord) async {
    return (select(words)..where((table) => table.word.equals(inputWord)))
        .getSingle();
  }

  Future<int> _getWordID(String word) async {
    return (await _getWordFromString(word)).id;
  }

  Future<int> _getExistingOrNewWordID(String inputWord) async {
    final Word searchedWord = await (_getWordFromString(inputWord));

    if (searchedWord != null) {
      return searchedWord.id;
    } else {
      return await into(words).insert(Word(word: inputWord));
    }
  }

  Future<int> _getExistingOrNewEntryID(int wordID, WordCard wordCard) async {
    final Entry searchEntry = await (select(entries)
          ..where((table) => table.wordId.equals(wordID)))
        .getSingle();

    if (searchEntry != null) {
      return searchEntry.id;
    } else {
      return await into(entries).insert(
        Entry(
          wordId: wordID,
          addedOn: DateTime.now(),
          pronunciation: wordCard.pronunciation,
        ),
      );
    }
  }

  Future<Entry> _getEntryByWord(String word) async {
    final int wordID = await _getWordID(word);
    return (select(entries)..where((table) => table.wordId.equals(wordID)))
        .getSingle();
  }

  Future<int> _getExistingOrNewSyllableID(String inputSyllable) async {
    final Syllable searchSyllable = await (select(syllables)
          ..where((table) => table.syllable.equals(inputSyllable)))
        .getSingle();

    if (searchSyllable != null) {
      return searchSyllable.id;
    } else {
      return await into(syllables).insert(Syllable(syllable: inputSyllable));
    }
  }

  Future<int> _getExistingOrNewExampleID(String inputExample) async {
    final Example searchExample = await (select(examples)
          ..where((table) => table.sentence.equals(inputExample)))
        .getSingle();
    if (searchExample != null) {
      return searchExample.id;
    } else {
      return await into(examples).insert(Example(sentence: inputExample));
    }
  }

  Future<void> _linkEntryAndSyllable(int entryID, int syllableID) async {
    await into(syllableList).insert(
      SyllableListData(entryId: entryID, syllableId: syllableID),
    );
  }

  Future<void> _linkSenseAndExample(int exampleID, int senseID) async {
    await into(exampleList).insert(
      ExampleListData(exampleId: exampleID, senseId: senseID),
    );
  }

  Future<void> _linkSenseAndThesaurus(
    int senseID,
    int wordID, {
    bool isAntonym = false,
  }) async {
    await into(thesaurusList).insert(
      ThesaurusListData(
        senseId: senseID,
        wordId: wordID,
        isAntonym: isAntonym,
      ),
    );
  }

  Future<void> _insertEntrySenseData(
    int entryID,
    List<WordCardDetails> detailList,
  ) async {
    for (final WordCardDetails wordCardDetails in detailList) {
      //? Step 4.1: Dealing with Part of Speech String
      //? ==============================================================
      // Same as word
      final int partOfSpeechID =
          PART_OF_SPEECH_TYPE_TO_ID[wordCardDetails.partOfSpeech];

      //? Step 4.2: Dealing with Sense data
      //? ==============================================================
      // Same as entry
      int senseID = await into(senses).insert(Sense(
        definition: wordCardDetails.definition,
        entryId: entryID,
        partOfSpeech: partOfSpeechID,
      ));

      //? Step 4.3: Dealing with Examples data
      //? ==============================================================
      // Same as syllables
      for (final String example in wordCardDetails.exampleList) {
        if (example.isEmpty) continue;
        final int exampleID = await _getExistingOrNewExampleID(example);
        await _linkSenseAndExample(exampleID, senseID);
      }

      //? Step 4.4: Store synonyms into thesaurus table
      //? ==============================================================
      // Same as syllables
      for (final String synonym in wordCardDetails.synonymList) {
        if (synonym.isEmpty) continue;
        final int synonymWordID = await _getExistingOrNewWordID(synonym);
        await _linkSenseAndThesaurus(senseID, synonymWordID);
      }

      //? Step 4.5: Store antonyms into thesaurus table
      //? ==============================================================
      // Same as syllables
      for (final String antonym in wordCardDetails.antonymList) {
        if (antonym.isEmpty) continue;
        final int antonymWordID = await _getExistingOrNewWordID(antonym);
        await _linkSenseAndThesaurus(senseID, antonymWordID, isAntonym: true);
      }
    }
  }

  Future<void> _insertEntrySyllables(
    int entryID,
    List<String> syllableList,
  ) async {
    for (final String s in syllableList) {
      final int syllableID = await _getExistingOrNewSyllableID(s);
      await _linkEntryAndSyllable(entryID, syllableID);
    }
  }

  Future _handleSavedUsageInfo() async {
    final UsageInfoData dbUsageInfoData = await _getUsageInformation();

    if (dbUsageInfoData == null) {
      await into(usageInfo)
          .insert(UsageInfoData(wordsSaved: 1, date: _getOnlyTimeToday()));
    } else {
      await (update(usageInfo)
            ..where((table) => table.date.equals(dbUsageInfoData.date)))
          .write(UsageInfoData(wordsSaved: dbUsageInfoData.wordsSaved + 1));
    }
  }

  Future<bool> insertWordCard(WordCard wordCard) async {
    //? Step 1: Dealing with Word String
    //? ==============================================================
    // Do either of the following.
    // If word exists in table, then get the word ID.
    // Else insert word into table and then get the word ID.
    final int wordID = await _getExistingOrNewWordID(wordCard.word);

    //? Step 2: Dealing with Entry data
    //? ==============================================================
    // Do either of the following.
    // If entry exists in table, then get the entry ID.
    // Else insert entry into table and then get the entry ID.
    final int entryID = await _getExistingOrNewEntryID(wordID, wordCard);

    //? Step 3: Dealing with the syllable data
    //? ==============================================================
    // First get the Syllable ID.
    // Next use the Syllable ID and entry ID to link the entry and
    // the syllable.
    await _insertEntrySyllables(entryID, wordCard.syllables);

    //? Step 4: Dealing with senses list data
    await _insertEntrySenseData(entryID, wordCard.detailList);

    //? Step 5: Increment insert count
    await _handleSavedUsageInfo();

    return true;
  }

  Future<List<Syllable>> _getEntrySyllables(int entryID) async =>
      (await (select(syllableList)
                ..where((table) => table.entryId.equals(entryID)))
              .join([
        leftOuterJoin(
            syllables, syllables.id.equalsExp(syllableList.syllableId))
      ]).get())
          .map((rows) => rows.readTable(syllables))
          .toList();

  Future<List<Sense>> _getEntrySenses(int entryID) async {
    return (select(senses)..where((table) => table.entryId.equals(entryID)))
        .get();
  }

  Future<List<Example>> _getSenseExamples(int senseID) async =>
      (await (select(exampleList)
                ..where((table) => table.senseId.equals(senseID)))
              .join([
        leftOuterJoin(examples, examples.id.equalsExp(exampleList.exampleId))
      ]).get())
          .map((rows) => rows.readTable(examples))
          .toList();

  Future<List<String>> _getSenseThesaurus({
    int senseID,
    bool isAntonym = false,
  }) async =>
      (await (select(thesaurusList)
                ..where((table) => table.senseId.equals(senseID))
                ..where((table) => table.isAntonym.equals(isAntonym)))
              .join([
        leftOuterJoin(words, words.id.equalsExp(thesaurusList.wordId))
      ]).get())
          .map((rows) => rows.readTable(words))
          .map((row) => row.word)
          .toList();

  Future<WordCard> getWordCard(String word) async {
    final List<WordCardDetails> resultDetailsList = [];

    //? Step 1: Get entry level details.
    final Entry dbEntry = await _getEntryByWord(word);

    //? Step 2: Get syllables
    final List<String> resultSyllableList = (await _getEntrySyllables(
      dbEntry.id,
    ))
        .map((row) => row.syllable)
        .toList();

    //? Step 3: Get sense level details.
    final List<Sense> dbSenseList = await _getEntrySenses(dbEntry.id);

    for (final Sense dbSense in dbSenseList) {
      final List<String> resultExampleList =
          (await _getSenseExamples(dbSense.id))
              .map((row) => row.sentence)
              .toList();

      resultDetailsList.add(
        WordCardDetails(
          id: dbSense.id,
          synonymList: await _getSenseThesaurus(
            senseID: dbSense.id,
          ),
          antonymList: await _getSenseThesaurus(
            senseID: dbSense.id,
            isAntonym: true,
          ),
          definition: dbSense.definition,
          exampleList: resultExampleList,
          partOfSpeech: ID_TO_PART_OF_SPEECH_TYPE[dbSense.partOfSpeech],
        ),
      );
    }

    return WordCard(
      id: dbEntry.id,
      word: word,
      pronunciation: dbEntry.pronunciation,
      syllables: resultSyllableList,
      detailList: resultDetailsList,
    );
  }

  Future<int> _deleteSenseExampleLinks(int senseID) async {
    return await (delete(exampleList)
          ..where((table) => table.senseId.equals(senseID)))
        .go();
  }

  Future<int> _deleteSenseThesaurusLinks(int senseID, bool isAntonym) async {
    return await (delete(thesaurusList)
          ..where((table) => table.senseId.equals(senseID)..equals(isAntonym)))
        .go();
  }

  Future<int> _deleteSenseByID(int id) async {
    return await (delete(senses)..where((table) => table.id.equals(id))).go();
  }

  Future<void> _deleteEntrySenseData(int entryID) async {
    final List<Sense> dbSenseList = await _getEntrySenses(entryID);

    for (final Sense dbSense in dbSenseList) {
      //? Step 1: Handle Example links
      await _deleteSenseExampleLinks(dbSense.id);

      //? Step 2: Handle Synonym links
      await _deleteSenseThesaurusLinks(dbSense.id, false);

      //? Step 3: Handle Antonym links
      await _deleteSenseThesaurusLinks(dbSense.id, true);

      //? Step 3: Handle the sense itself.
      await _deleteSenseByID(dbSense.id);
    }
  }

  Future<int> _deleteEntrySyllableLinks(int entryID) async {
    return await (delete(syllableList)
          ..where((table) => table.entryId.equals(entryID)))
        .go();
  }

  Future<int> _deleteEntryByID(int entryID) async {
    return await (delete(entries)..where((table) => table.id.equals(entryID)))
        .go();
  }

  Future _handleDeleteUsageInfo() async {
    final UsageInfoData dbUsageInfoData = await _getUsageInformation();

    if (dbUsageInfoData == null) {
      await into(usageInfo)
          .insert(UsageInfoData(wordsDeleted: 1, date: _getOnlyTimeToday()));
    } else {
      await (update(usageInfo)
            ..where((table) => table.date.equals(dbUsageInfoData.date)))
          .write(UsageInfoData(wordsDeleted: dbUsageInfoData.wordsDeleted + 1));
    }
  }

  Future<bool> deleteWordCard(String word) async {
    final Entry dbEntry = await _getEntryByWord(word);
    await _deleteEntrySenseData(dbEntry.id);
    await _deleteEntrySyllableLinks(dbEntry.id);
    await _deleteEntryByID(dbEntry.id);
    await _handleDeleteUsageInfo();
    return true;
  }

  Future<void> _updateSenseDetails(
          WordCardDetails details, int entryID) async =>
      (update(senses)..where((table) => table.id.equals(details.id))).write(
        Sense(
          definition: details.definition,
          entryId: entryID,
          partOfSpeech: PART_OF_SPEECH_TYPE_TO_ID[details.partOfSpeech],
        ),
      );

  Future _updateEntrySyllables(WordCard wordCard) async {
    final List<String> dbSyllablesList = (await _getEntrySyllables(wordCard.id))
        .map((row) => row.syllable)
        .toList();

    for (final String syl in wordCard.syllables) {
      if (syl.isNotEmpty) {
        if (dbSyllablesList.contains(syl) == false) {
          final int sylID = await _getExistingOrNewSyllableID(syl);
          await _linkEntryAndSyllable(wordCard.id, sylID);
        }
      }
    }

    for (final String dbSyl in dbSyllablesList) {
      if (wordCard.syllables.contains(dbSyl) == false) {
        final int sbSylID = await _getExistingOrNewExampleID(dbSyl);
        await (delete(syllableList)
              ..where((table) => table.entryId.equals(wordCard.id))
              ..where((table) => table.syllableId.equals(sbSylID)))
            .go();
      }
    }
  }

  Future _updateSenseExamples(WordCardDetails details) async {
    final List<String> dbExampleList = (await _getSenseExamples(details.id))
        .map((row) => row.sentence)
        .toList();

    for (final String exampleSentence in details.exampleList) {
      if (exampleSentence.isNotEmpty) {
        if (dbExampleList.contains(exampleSentence) == false) {
          final int exampleID =
              await _getExistingOrNewExampleID(exampleSentence);
          await _linkSenseAndExample(exampleID, details.id);
        }
      }
    }

    for (final String dbExampleSentence in dbExampleList) {
      if (details.exampleList.contains(dbExampleSentence)) continue;
      final int exampleID = await _getExistingOrNewExampleID(dbExampleSentence);
      await (delete(exampleList)
            ..where((table) => table.senseId.equals(details.id))
            ..where((table) => table.exampleId.equals(exampleID)))
          .go();
    }
  }

  Future _updateSenseThesaurus(WordCardDetails details, bool isAntonym) async {
    final List<String> dbThesaurusList =
        (await _getSenseThesaurus(senseID: details.id, isAntonym: isAntonym));

    final List<String> detailsthesaurusList =
        isAntonym ? details.antonymList : details.synonymList;

    for (final String thesaurus in detailsthesaurusList) {
      if (thesaurus.isNotEmpty) {
        if (dbThesaurusList.contains(thesaurus) == false) {
          final int thesaurusWordID = await _getExistingOrNewWordID(thesaurus);
          await _linkSenseAndThesaurus(
            details.id,
            thesaurusWordID,
            isAntonym: isAntonym,
          );
        }
      }
    }

    for (final String dbthesaurus in dbThesaurusList) {
      if (detailsthesaurusList.contains(dbthesaurus)) continue;
      final int thesaurusWordID = await _getExistingOrNewExampleID(dbthesaurus);
      await (delete(thesaurusList)
            ..where((table) => table.senseId.equals(details.id))
            ..where((table) => table.wordId.equals(thesaurusWordID)))
          .go();
    }
  }

  Future _handleUpdateUsageInfo() async {
    final UsageInfoData dbUsageInfoData = await _getUsageInformation();

    if (dbUsageInfoData == null) {
      await into(usageInfo)
          .insert(UsageInfoData(wordsEdited: 1, date: _getOnlyTimeToday()));
    } else {
      await (update(usageInfo)
            ..where((table) => table.date.equals(dbUsageInfoData.date)))
          .write(UsageInfoData(wordsEdited: dbUsageInfoData.wordsEdited + 1));
    }
  }

  Future<bool> updateWordCard(WordCard wordCard) async {
    //? Step 1: Update entry details
    await (update(entries)..where((table) => table.id.equals(wordCard.id)))
        .write(
      Entry(pronunciation: wordCard.pronunciation),
    );

    //? Step 2: update syllables
    await _updateEntrySyllables(wordCard);

    //? Step 3: delete and reinsert senses
    for (final WordCardDetails details in wordCard.detailList) {
      if (details.id == null) {
        await _insertEntrySenseData(wordCard.id, wordCard.detailList);
      } else {
        await _updateSenseDetails(details, wordCard.id);
        await _updateSenseExamples(details);
        await _updateSenseThesaurus(details, false);
        await _updateSenseThesaurus(details, true);
      }
    }

    await _handleUpdateUsageInfo();

    return true;
  }
}