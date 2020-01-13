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
  IntColumn get partOfSpeech =>
      integer().customConstraint('REFERENCES parts_of_speech(id)')();
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
])
class WordDao extends DatabaseAccessor<CardDatabase> with _$WordDaoMixin {
  final CardDatabase cardDatabase;

  WordDao(this.cardDatabase) : super(cardDatabase);

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

    return true;
  }

  Future<List<SyllableListData>> _getEntrySyllableList(int entryID) async {
    return (select(syllableList)
          ..where((table) => table.entryId.equals(entryID)))
        .get();
  }

  Future<Syllable> _getSyllableFromID(int syllableID) async {
    return (select(syllables)..where((table) => table.id.equals(syllableID)))
        .getSingle();
  }

  Future<List<Sense>> _getEntrySenseList(int entryID) async {
    return (select(senses)..where((table) => table.entryId.equals(entryID)))
        .get();
  }

  Future<List<ExampleListData>> _getSenseExampleLinkList(int senseID) async {
    return (select(exampleList)
          ..where((table) => table.senseId.equals(senseID)))
        .get();
  }

  Future<Example> _getExampleByID(int id) {
    return (select(examples)..where((table) => table.id.equals(id)))
        .getSingle();
  }

  Future<List<ThesaurusListData>> _getSenseThesaurusLinkList(
    int senseID,
    bool isAntonym,
  ) async {
    return ((select(thesaurusList)..where((table) => table.senseId.equals(senseID)))
          ..where((table) => table.isAntonym.equals(isAntonym)))
        .get();
  }

  Future<List<String>> _getSenseThesaurusList({
    int senseID,
    bool isAntonym = false,
  }) async {
    final List<String> result = [];
    final List<ThesaurusListData> list =
        await _getSenseThesaurusLinkList(senseID, isAntonym);
    for (final ThesaurusListData data in list) {
      final String e = (await (select(words)
                ..where((table) => table.id.equals(data.wordId)))
              .getSingle())
          .word;
      result.add(e);
    }

    return result;
  }

  Future<WordCard> getWordCard(String word) async {
    final List<String> resultSyllableList = [];
    final List<WordCardDetails> resultDetailsList = [];

    //? Step 1: Get entry level details.
    final Entry entry = await _getEntryByWord(word);

    //? Step 2: Get syllables
    final List<SyllableListData> dbSyllableList = await _getEntrySyllableList(
      entry.id,
    );
    for (final SyllableListData dbSyllable in dbSyllableList) {
      final Syllable syllableInst = await _getSyllableFromID(
        dbSyllable.syllableId,
      );
      resultSyllableList.add(syllableInst.syllable);
    }

    //? Step 3: Get sense level details.
    final List<Sense> senseList = await _getEntrySenseList(entry.id);

    for (final Sense sense in senseList) {
      final List<String> resultExampleList = [];
      final List<ExampleListData> dbExampleDataList =
          await _getSenseExampleLinkList(sense.id);

      for (final ExampleListData data in dbExampleDataList) {
        final Example dbExample = await _getExampleByID(data.exampleId);
        resultExampleList.add(dbExample.sentence);
      }

      resultDetailsList.add(WordCardDetails(
        synonymList: await _getSenseThesaurusList(
          senseID: sense.id,
        ),
        antonymList: await _getSenseThesaurusList(
          senseID: sense.id,
          isAntonym: true,
        ),
        definition: sense.definition,
        exampleList: resultExampleList,
        partOfSpeech: ID_TO_PART_OF_SPEECH_TYPE[sense.partOfSpeech],
      ));
    }

    return WordCard(
      word: word,
      pronunciation: PronunciationEntity.Pronunciation(
        all: entry.pronunciation,
      ),
      syllables: SyllableEntity.Syllable(
        count: resultSyllableList.length,
        list: resultSyllableList,
      ),
      detailList: resultDetailsList,
    );
  }

  Future<List<WordDetailsSummary>> getSavedWords() async {
    final List<Entry> dbEntryList = await select(entries).get();
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
    final List<Sense> dbSenseList = await _getEntrySenseList(entryID);

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

  Future<bool> deleteWordCard(String word) async {
    final Entry dbEntry = await _getEntryByWord(word);
    await _deleteEntrySenseData(dbEntry.id);
    await _deleteEntrySyllableLinks(dbEntry.id);
    await _deleteEntryByID(dbEntry.id);
    return true;
  }

  Future<bool> updateWordCard(WordCard wordCard) async {
    final Entry dbEntry = await _getEntryByWord(wordCard.word);

    //? Step 1: Update entry details
    await update(entries).replace(
      Entry(
        id: dbEntry.id,
        pronunciation: wordCard.pronunciation.all,
        wordId: dbEntry.wordId,
        addedOn: dbEntry.addedOn,
      ),
    );

    //? Step 2: Delete and reinsert updated syllables
    await _deleteEntrySyllableLinks(dbEntry.id);
    await _insertEntrySyllables(dbEntry.id, wordCard.syllables.list);

    //? Step 3: Delete and reinsert senses
    await _deleteEntrySenseData(dbEntry.id);
    await _insertEntrySenseData(dbEntry.id, wordCard.detailList);

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

  // Future<bool> deleteCardsOfAnEntry(int entryID) async {
  //   final List<int> dbCardIDs = await _getEntryQuizCardIDs(entryID);
  //   for (final int id in dbCardIDs) await _deleteCardAndCardInfo(id);
  //   return true;
  // }

  // Future<void> _checkAndDeleteCardInfo(int cardInfoID, int senseID) async {
  //   final CardInfoData dbCardInfoData = await (select(cardInfo)
  //         ..where((table) => table.id.equals(cardInfoID)))
  //       .getSingle();
  //   if (dbCardInfoData.senseId == senseID)
  //     await _deleteCardInfoWithID(cardInfoID);
  // }

  // Future<bool> deleteCardOfASense(int entryID, int senseID) async {
  //   final List<int> dbCardIDs = await _getEntryQuizCardIDs(entryID);
  //   for (final int id in dbCardIDs) {
  //     final Card dbCard = await _getCardByID(id);
  //     await _checkAndDeleteCardInfo(dbCard.frontId, senseID);
  //     await _checkAndDeleteCardInfo(dbCard.backId, senseID);
  //   }
  //   return true;
  // }

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

  Future<int> updateCardLevel(int cardID, int level, DateTime nextDue) async {
    return (update(cards)..where((table) => table.id.equals(cardID))).write(
      Card(dueOn: nextDue, level: level),
    );
  }
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
];

//? flutter packages pub run build_runner watch --delete-conflicting-outputs

@UseMoor(tables: _CARD_DATABASE_TABLE_LIST, daos: [WordDao, CardDao])
class CardDatabase extends _$CardDatabase {
  CardDatabase()
      : super(
          FlutterQueryExecutor(path: 'word_card.sqlite', logStatements: true),
        );

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (OpeningDetails openingDetails) async {
          await this.customStatement('PRAGMA foreign_keys = ON');
        },
      );
}
