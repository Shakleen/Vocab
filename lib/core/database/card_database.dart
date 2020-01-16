import 'package:moor_flutter/moor_flutter.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/entities/syllable.dart' as SyllableEntity;
import 'package:vocab/core/entities/pronunciation.dart' as PronunciationEntity;
import 'package:vocab/core/entities/word_details_summary.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';

part 'card_database.g.dart';

//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//
//!                                                                 Tables classes                                                               !//
//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//

@DataClassName('Entry')
class Entries extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  DateTimeColumn get addedOn => dateTime()();
  TextColumn get pronunciation => text()();
  IntColumn get wordId => integer().customConstraint('REFERENCES words(id)')();
}

class Senses extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get entryId =>
      integer().customConstraint('REFERENCES entries(id)')();
  IntColumn get partOfSpeech => integer()();
  TextColumn get definition => text()();
}

class Words extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get word => text().withLength(min: 1).customConstraint('UNIQUE')();
}

class Examples extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get sentence =>
      text().withLength(min: 1).customConstraint('UNIQUE')();
}

class Syllables extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get syllable =>
      text().withLength(min: 1).customConstraint('UNIQUE')();
}

class ThesaurusList extends Table {
  IntColumn get senseId =>
      integer().customConstraint('REFERENCES senses(id)')();
  IntColumn get wordId => integer().customConstraint('REFERENCES words(id)')();
  BoolColumn get isAntonym => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {senseId, wordId, isAntonym};
}

class ExampleList extends Table {
  IntColumn get senseId =>
      integer().customConstraint('REFERENCES senses(id)')();
  IntColumn get exampleId =>
      integer().customConstraint('REFERENCES examples(id)')();

  @override
  Set<Column> get primaryKey => {senseId, exampleId};
}

class SyllableList extends Table {
  IntColumn get entryId =>
      integer().customConstraint('REFERENCES entries(id)')();
  IntColumn get syllableId =>
      integer().customConstraint('REFERENCES syllables(id)')();

  @override
  Set<Column> get primaryKey => {entryId, syllableId};
}

class EntryQuizCards extends Table {
  IntColumn get cardId => integer().customConstraint('REFERENCES cards(id)')();
  IntColumn get entryId =>
      integer().customConstraint('REFERENCES entries(id)')();

  @override
  Set<Column> get primaryKey => {cardId, entryId};
}

class Cards extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get frontId =>
      integer().customConstraint('REFERENCES card_info(id)')();
  IntColumn get backId =>
      integer().customConstraint('REFERENCES card_info(id)')();
  IntColumn get level => integer().nullable().withDefault(Constant(0))();
  BoolColumn get isImportant =>
      boolean().nullable().withDefault(Constant(false))();
  DateTimeColumn get dueOn => dateTime()();
}

class CardInfo extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get entryId =>
      integer().customConstraint('REFERENCES entries(id)')();
  IntColumn get senseId =>
      integer().customConstraint('REFERENCES senses(id)')();
  IntColumn get attributeType => integer()();
}

class UsageInfo extends Table {
  IntColumn get wordsSearched =>
      integer().withDefault(Constant(0)).nullable()();
  IntColumn get wordsSaved => integer().withDefault(Constant(0)).nullable()();
  IntColumn get cardsQuizzed => integer().withDefault(Constant(0)).nullable()();
  IntColumn get wordsEdited => integer().withDefault(Constant(0)).nullable()();
  IntColumn get cardsDeleted => integer().withDefault(Constant(0)).nullable()();
  DateTimeColumn get date => dateTime()
      .nullable()
      .withDefault(Constant(DateTime.now()))();

  @override
  Set<Column> get primaryKey => {date};
}

//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//
//!                                                                 DAO classes                                                                  !//
//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//

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

  Future handleWordsSearchUsageInfo() async {
    final UsageInfoData dbUsageInfoData = await _getUsageInformation();

    if (dbUsageInfoData == null) {
      await into(usageInfo).insert(UsageInfoData(wordsSearched: 1));
    } else {
      await (update(usageInfo)
            ..where((table) => table.id.equals(dbUsageInfoData.id)))
          .write(UsageInfoData(wordsSearched: dbUsageInfoData.wordsSearched + 1));
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
          pronunciation: wordCard.pronunciation.all,
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
      await into(usageInfo).insert(UsageInfoData(wordsSaved: 1));
    } else {
      await (update(usageInfo)
            ..where((table) => table.id.equals(dbUsageInfoData.id)))
          .write(UsageInfoData(wordsSaved: dbUsageInfoData.wordsSaved + 1));
    }
  }

  Future<UsageInfoData> _getUsageInformation() =>
      (select(usageInfo)..where((table) => table.date.equals(DateTime.now())))
          .getSingle();

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
    await _insertEntrySyllables(entryID, wordCard.syllables.list);

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
      pronunciation: PronunciationEntity.Pronunciation(
        all: dbEntry.pronunciation,
      ),
      syllables: SyllableEntity.Syllable(
        count: resultSyllableList.length,
        list: resultSyllableList,
      ),
      detailList: resultDetailsList,
    );
  }

  Future<List<WordDetailsSummary>> getSavedWords() async {
    final List<Entry> dbEntryList = (await (select(words)
              ..orderBy([
                (table) => OrderingTerm(
                      expression: table.word,
                      mode: OrderingMode.asc,
                    )
              ]))
            .join(
                [innerJoin(entries, entries.wordId.equalsExp(words.id))]).get())
        .map((table) => table.readTable(entries))
        .toList();

    final List<WordDetailsSummary> detailSummaryList = [];

    for (final Entry dbEntry in dbEntryList) {
      final Word word = await (select(words)
            ..where((table) => table.id.equals(dbEntry.wordId)))
          .getSingle();

      final List<Sense> dbSenseList = await (select(senses)
            ..where((table) => table.entryId.equals(dbEntry.id)))
          .get();

      detailSummaryList.add(
        WordDetailsSummary(
          word: word.word,
          addedOn: dbEntry.addedOn,
          senses: dbSenseList.length,
        ),
      );
    }

    return detailSummaryList;
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
      await into(usageInfo).insert(UsageInfoData(cardsDeleted: 1));
    } else {
      await (update(usageInfo)
            ..where((table) => table.id.equals(dbUsageInfoData.id)))
          .write(UsageInfoData(cardsDeleted: dbUsageInfoData.cardsDeleted + 1));
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

    for (final String syl in wordCard.syllables.list) {
      if (syl.isNotEmpty) {
        if (dbSyllablesList.contains(syl) == false) {
          final int sylID = await _getExistingOrNewSyllableID(syl);
          await _linkEntryAndSyllable(wordCard.id, sylID);
        }
      }
    }

    for (final String dbSyl in dbSyllablesList) {
      if (wordCard.syllables.list.contains(dbSyl) == false) {
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
      await into(usageInfo).insert(UsageInfoData(wordsEdited: 1));
    } else {
      await (update(usageInfo)
            ..where((table) => table.id.equals(dbUsageInfoData.id)))
          .write(UsageInfoData(wordsEdited: dbUsageInfoData.wordsEdited + 1));
    }
  }

  Future<bool> updateWordCard(WordCard wordCard) async {
    //? Step 1: Update entry details
    await (update(entries)..where((table) => table.id.equals(wordCard.id)))
        .write(
      Entry(pronunciation: wordCard.pronunciation.all),
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

@UseDao(tables: [
  Entries,
  Senses,
  Words,
  Examples,
  Syllables,
  ThesaurusList,
  ExampleList,
  SyllableList,
  Cards,
  CardInfo,
  EntryQuizCards,
  UsageInfo,
])
class CardDao extends DatabaseAccessor<CardDatabase> with _$CardDaoMixin {
  final CardDatabase cardDatabase;

  CardDao(this.cardDatabase) : super(cardDatabase);

  /// Fetches an [Entry] for [word] string.
  Future<Entry> _getEntryByWord(String word) async =>
      (await (select(words)..where((table) => table.word.equals(word))).join([
        leftOuterJoin(entries, entries.wordId.equalsExp(words.id))
      ]).getSingle())
          .readTable(entries);

  /// Fetches a List of [Sense] objects for an entry with [entryID].
  Future<List<Sense>> _getEntrySenses(int entryID) async =>
      (select(senses)..where((table) => table.entryId.equals(entryID))).get();

  /// Inserts a quiz card information to the database.
  Future<int> _insertCard({
    int entryID,
    int senseID,
    AttributeType frontType,
    AttributeType backType,
    DateTime dueDate,
  }) async {
    final int frontID = await _insertCardInfo(entryID, senseID, frontType);
    final int backID = await _insertCardInfo(entryID, senseID, backType);
    final int cardID = await into(cards).insert(Card(
      frontId: frontID,
      backId: backID,
      dueOn: dueDate != null ? dueDate : DateTime.now(),
    ));

    await _linkEntryAndCard(cardID, entryID);

    return cardID;
  }

  /// Inserts the information of a card side into the database.
  Future<int> _insertCardInfo(
    int entryID,
    int senseID,
    AttributeType type,
  ) async =>
      into(cardInfo).insert(
        CardInfoData(
          entryId: entryID,
          senseId: senseID,
          attributeType: ATTRIBUTE_TYPE_TO_ID[type],
        ),
      );

  /// Links the entry with [entryID] and newly inserted card with [cardID].
  Future<void> _linkEntryAndCard(int cardID, int entryID) async =>
      into(entryQuizCards).insert(
        EntryQuizCard(cardId: cardID, entryId: entryID),
      );

  /// Creates new quiz cards for a word with information contained in [wordCard] parameter.
  ///
  /// Every word will have at most 8 types of cards.
  Future<bool> createNewQuizCards(WordCard wordCard) async {
    final Entry dbEntry = await _getEntryByWord(wordCard.word);
    final List<Sense> dbSenseList = await _getEntrySenses(dbEntry.id);

    //? Card 1: Front = Spelling, Back = Pronunciation
    await _insertCard(
      entryID: dbEntry.id,
      senseID: dbSenseList[0].id,
      frontType: AttributeType.Spelling,
      backType: AttributeType.Pronunciation,
    );

    //? Card 2: Front = Pronunciation, Back = Spelling
    await _insertCard(
      entryID: dbEntry.id,
      senseID: dbSenseList[0].id,
      frontType: AttributeType.Pronunciation,
      backType: AttributeType.Spelling,
    );

    //? Card 3: Front = Spelling, Back = Syllables
    await _insertCard(
      entryID: dbEntry.id,
      senseID: dbSenseList[0].id,
      frontType: AttributeType.Spelling,
      backType: AttributeType.Syllables,
    );

    int delay = 0;

    for (final Sense sense in dbSenseList) {
      final List<ExampleListData> dbExamples = await (select(exampleList)
            ..where((table) => table.senseId.equals(sense.id)))
          .get();

      if (dbExamples.isNotEmpty) {
        //? Card 4: Front = Definition, Back = Example
        await _insertCard(
          entryID: dbEntry.id,
          senseID: sense.id,
          frontType: AttributeType.Definition,
          backType: AttributeType.Example,
          dueDate: DateTime.now().add(Duration(days: delay)),
        );

        //? Card 5: Front = Example, Back = Definition
        await _insertCard(
          entryID: dbEntry.id,
          senseID: sense.id,
          frontType: AttributeType.Example,
          backType: AttributeType.Definition,
          dueDate: DateTime.now().add(Duration(days: delay)),
        );

        final List<ThesaurusListData> dbSynList = await (select(thesaurusList)
              ..where((table) => table.senseId.equals(sense.id))
              ..where((table) => table.isAntonym.equals(false)))
            .get();

        if (dbSynList.isNotEmpty) {
          //? Card 6: Front = Example, Back = Synonyms
          await _insertCard(
            entryID: dbEntry.id,
            senseID: sense.id,
            frontType: AttributeType.Example,
            backType: AttributeType.Synonyms,
            dueDate: DateTime.now().add(Duration(days: delay)),
          );
        }

        final List<ThesaurusListData> dbAntList = await (select(thesaurusList)
              ..where((table) => table.senseId.equals(sense.id))
              ..where((table) => table.isAntonym.equals(true)))
            .get();

        if (dbAntList.isNotEmpty) {
          //? Card 7: Front = Example, Back = Antonyms
          await _insertCard(
            entryID: dbEntry.id,
            senseID: sense.id,
            frontType: AttributeType.Example,
            backType: AttributeType.Antonyms,
            dueDate: DateTime.now().add(Duration(days: delay)),
          );
        }

        //? Card 8: Front = Example, Back = Part of speech
        await _insertCard(
          entryID: dbEntry.id,
          senseID: sense.id,
          frontType: AttributeType.Example,
          backType: AttributeType.PartOfSpeech,
          dueDate: DateTime.now().add(Duration(days: delay)),
        );

        delay += 1;
      }
    }

    return true;
  }

  Future<List<int>> _getEntryQuizCardIDs(int entryID) async {
    return (await (select(entryQuizCards)
              ..where((table) => table.entryId.equals(entryID)))
            .get())
        .map(
          (row) => row.cardId,
        )
        .toList();
  }

  Future<Card> _getCardByID(int id) async =>
      (select(cards)..where((table) => table.id.equals(id))).getSingle();

  Future<void> _deleteCardInfoWithID(int cardInfoID) async =>
      (delete(cardInfo)..where((table) => table.id.equals(cardInfoID))).go();

  Future<void> _deleteEntryAndQuizCardLinker(int cardID) async =>
      (delete(entryQuizCards)..where((table) => table.cardId.equals(cardID)))
          .go();

  Future<void> _deleteCardWithID(int cardID) async =>
      (delete(cards)..where((table) => table.id.equals(cardID))).go();

  Future<bool> deleteQuizCard(int cardID) async {
    await _deleteEntryAndQuizCardLinker(cardID);
    final Card dbCard = await _getCardByID(cardID);
    await _deleteCardWithID(cardID);
    await _deleteCardInfoWithID(dbCard.frontId);
    await _deleteCardInfoWithID(dbCard.backId);
    return true;
  }

  Future<List<Card>> _getDueCards(int limit) async => (select(cards)
        ..where((table) => table.dueOn.isSmallerOrEqualValue(DateTime.now()))
        ..orderBy([
          (table) => OrderingTerm(
                expression: table.level,
                mode: OrderingMode.asc,
              ),
          (table) => OrderingTerm(
                expression: table.isImportant,
                mode: OrderingMode.desc,
              ),
        ])
        ..limit(limit))
      .get();

  Future<CardInfoData> _getCardInfoFromID(int cardInfoID) async =>
      (select(cardInfo)..where((table) => table.id.equals(cardInfoID)))
          .getSingle();

  Future<Entry> _getEntryFromID(int entryID) async =>
      (select(entries)..where((table) => table.id.equals(entryID))).getSingle();

  Future<Word> _getWordByID(int id) async =>
      (select(words)..where((table) => table.id.equals(id))).getSingle();

  Future<List<String>> _getWordSyllables(int entryID) async =>
      (await (select(syllableList)
                ..where((table) => table.entryId.equals(entryID)))
              .join([
        leftOuterJoin(
            syllables, syllables.id.equalsExp(syllableList.syllableId))
      ]).get())
          .map((rows) => rows.readTable(syllables).syllable)
          .toList();

  Future<Sense> _getSenseByID(int senseID) async =>
      (select(senses)..where((table) => table.id.equals(senseID))).getSingle();

  Future<List<String>> _getSenseExamples(int senseID) async =>
      (await (select(exampleList)
                ..where((table) => table.senseId.equals(senseID)))
              .join([
        leftOuterJoin(examples, examples.id.equalsExp(exampleList.exampleId))
      ]).get())
          .map((rows) => rows.readTable(examples).sentence)
          .toList();

  Future<List<String>> _getSenseThesauruses(
    int senseID, {
    bool isAntonym = false,
  }) async =>
      (await (select(thesaurusList)
                ..where((table) => table.senseId.equals(senseID))
                ..where((table) => table.isAntonym.equals(isAntonym)))
              .join([
        leftOuterJoin(words, words.id.equalsExp(thesaurusList.wordId))
      ]).get())
          .map((rows) => rows.readTable(words).word)
          .toList();

  Future<String> _getCardSideInfo(CardInfoData dbCardInfoData) async {
    if (dbCardInfoData.attributeType <= 3) {
      final Entry dbEntry = await _getEntryFromID(dbCardInfoData.entryId);

      switch (ID_TO_ATTRIBUTE_TYPE[dbCardInfoData.attributeType]) {
        case AttributeType.Spelling:
          return (await _getWordByID(dbEntry.wordId)).word;
        case AttributeType.Pronunciation:
          return dbEntry.pronunciation;
        case AttributeType.Syllables:
          final List<String> output = await _getWordSyllables(dbEntry.id);
          return output.join(' | ');
        default:
          return null;
      }
    } else {
      final Sense dbSense = await _getSenseByID(dbCardInfoData.senseId);

      switch (ID_TO_ATTRIBUTE_TYPE[dbCardInfoData.attributeType]) {
        case AttributeType.Example:
          final List<String> output = await _getSenseExamples(dbSense.id);
          return output.join(' | ');
        case AttributeType.Definition:
          return dbSense.definition;
        case AttributeType.Synonyms:
          final List<String> output = await _getSenseThesauruses(dbSense.id);
          return output.join(' | ');
        case AttributeType.Antonyms:
          final List<String> output = await _getSenseThesauruses(
            dbSense.id,
            isAntonym: true,
          );
          return output.join(' | ');
        case AttributeType.PartOfSpeech:
          return getPartOfSpeechString(
            ID_TO_PART_OF_SPEECH_TYPE[dbSense.partOfSpeech],
          );
        default:
          return null;
      }
    }
  }

  Future<String> _getWordFromCardID(int cardID) async =>
      (await (select(cards)..where((table) => table.id.equals(cardID))).join([
        leftOuterJoin(
            entryQuizCards, entryQuizCards.cardId.equalsExp(cards.id)),
        leftOuterJoin(entries, entries.id.equalsExp(entryQuizCards.entryId)),
        leftOuterJoin(words, words.id.equalsExp(entries.wordId)),
      ]).getSingle())
          .readTable(words)
          .word;

  Future<List<QuizCard>> getQuizCards({int noOfCards = 25}) async {
    final List<Card> dbCardList = await _getDueCards(noOfCards);
    final List<QuizCard> output = [];

    for (final Card dbCard in dbCardList) {
      //? Step 1: get card side information for front
      final CardInfoData dbFrontCardInfo =
          await _getCardInfoFromID(dbCard.frontId);
      final String front = await _getCardSideInfo(dbFrontCardInfo);

      //? Step 2: get card side information for back
      final CardInfoData dbBackCardInfo =
          await _getCardInfoFromID(dbCard.backId);
      final String back = await _getCardSideInfo(dbBackCardInfo);

      //? Step 3: Get the word
      final String word = await _getWordFromCardID(dbCard.id);

      //? Step 4: create quiz card and add to output list
      output.add(
        QuizCard(
          word: word,
          id: dbCard.id,
          dueDate: dbCard.dueOn,
          isImportant: dbCard.isImportant,
          level: dbCard.level,
          frontType: ID_TO_ATTRIBUTE_TYPE[dbFrontCardInfo.attributeType],
          front: front,
          backType: ID_TO_ATTRIBUTE_TYPE[dbBackCardInfo.attributeType],
          back: back,
        ),
      );
    }

    return output;
  }

  Future<List<QuizCard>> getQuizCardsForWord(String word) async {
    final Entry dbEntry = await _getEntryByWord(word);
    final List<int> dbQuizCardIDs = await _getEntryQuizCardIDs(dbEntry.id);
    final List<QuizCard> output = [];

    for (final int cardID in dbQuizCardIDs) {
      final Card dbCard = await _getCardByID(cardID);

      final CardInfoData dbFrontCardInfo =
          await _getCardInfoFromID(dbCard.frontId);
      final String front = await _getCardSideInfo(dbFrontCardInfo);

      final CardInfoData dbBackCardInfo =
          await _getCardInfoFromID(dbCard.backId);
      final String back = await _getCardSideInfo(dbBackCardInfo);
      output.add(
        QuizCard(
          word: word,
          level: dbCard.level,
          dueDate: dbCard.dueOn,
          id: dbCard.id,
          isImportant: dbCard.isImportant,
          front: front,
          frontType: ID_TO_ATTRIBUTE_TYPE[dbFrontCardInfo.attributeType],
          back: back,
          backType: ID_TO_ATTRIBUTE_TYPE[dbBackCardInfo.attributeType],
        ),
      );
    }

    return output;
  }

  Future<int> toggleCardImportance(int cardID, bool status) async {
    return (update(cards)..where((table) => table.id.equals(cardID))).write(
      Card(isImportant: status),
    );
  }

  Future<UsageInfoData> _getUsageInformation() =>
      (select(usageInfo)..where((table) => table.date.equals(DateTime.now())))
          .getSingle();

  Future _handleQuizUsageInfo() async {
    final UsageInfoData dbUsageInfoData = await _getUsageInformation();

    if (dbUsageInfoData == null) {
      await into(usageInfo).insert(UsageInfoData(cardsQuizzed: 1));
    } else {
      await (update(usageInfo)
            ..where((table) => table.id.equals(dbUsageInfoData.id)))
          .write(UsageInfoData(cardsQuizzed: dbUsageInfoData.cardsQuizzed + 1));
    }
  }

  Future<int> updateCardLevel(int cardID, int level, DateTime nextDue) async {
    _handleQuizUsageInfo();
    return (update(cards)..where((table) => table.id.equals(cardID))).write(
      Card(dueOn: nextDue, level: level),
    );
  }
}

@UseDao(tables: [
  Entries,
  Senses,
  Words,
  Examples,
  Syllables,
  ThesaurusList,
  ExampleList,
  SyllableList,
  Cards,
  CardInfo,
  EntryQuizCards,
  UsageInfo,
])
class StatisticsDao extends DatabaseAccessor<CardDatabase>
    with _$StatisticsDaoMixin {
  final CardDatabase cardDatabase;

  StatisticsDao(this.cardDatabase) : super(cardDatabase);

  Future getPartOfSpeechStatistics() async {}

  Future getNoOfWordsAddedStatistics() async {}

  Future getNoOfWordsSearchedStatistics() async {}

  Future getNoOfWordsEditedStatistics() async {}

  Future getNoOfWordsDeletedStatistics() async {}

  Future getNoOfCardsQuizzedStatistics() async {}

  Future getCardLevelStatistics() async {}
}

//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//
//!                                                                 Database class                                                               !//
//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//

const List<Type> _CARD_DATABASE_TABLE_LIST = [
  Entries,
  Senses,
  Words,
  Examples,
  Syllables,
  ThesaurusList,
  ExampleList,
  SyllableList,
  EntryQuizCards,
  Cards,
  CardInfo,
  UsageInfo,
];

const List<Type> _DAO_LIST = const [
  WordDao,
  CardDao,
  StatisticsDao,
];

//? flutter packages pub run build_runner watch --delete-conflicting-outputs

@UseMoor(tables: _CARD_DATABASE_TABLE_LIST, daos: _DAO_LIST)
class CardDatabase extends _$CardDatabase {
  CardDatabase()
      : super(
          FlutterQueryExecutor(path: 'word_card.sqlite', logStatements: true),
        );

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (OpeningDetails openingDetails) async {
          await this.customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (Migrator m) {
          return m.createAllTables();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 3) {
            await m.deleteTable('part_of_speech');
            await m.createTable(usageInfo);
          }
        },
      );
}
