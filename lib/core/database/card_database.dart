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

class PartsOfSpeech extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  TextColumn get partOfSpeech =>
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

const Map<AttributeType, int> ATTRIBUTE_TYPE_ID = {
  AttributeType.Spelling: 1,
  AttributeType.Pronunciation: 2,
  AttributeType.Syllables: 3,
  AttributeType.Example: 4,
  AttributeType.Definition: 5,
  AttributeType.Synonyms: 6,
  AttributeType.Antonyms: 7,
  AttributeType.PartOfSpeech: 8,
};

@UseDao(tables: [
  Entries,
  Senses,
  Words,
  Examples,
  PartsOfSpeech,
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

  Future<int> _getExistingOrNewPartOfSpeechID(String partOfSpeech) async {
    final PartsOfSpeechData pos = await (select(partsOfSpeech)
          ..where((table) => table.partOfSpeech.equals(partOfSpeech)))
        .getSingle();

    if (pos != null) {
      return pos.id;
    } else {
      return await into(partsOfSpeech).insert(
        PartsOfSpeechData(partOfSpeech: partOfSpeech),
      );
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
      int entryID, List<WordCardDetails> detailList) async {
    for (final WordCardDetails wordCardDetails in detailList) {
      //? Step 4.1: Dealing with Part of Speech String
      //? ==============================================================
      // Same as word
      final int partOfSpeechID = await _getExistingOrNewPartOfSpeechID(
        wordCardDetails.partOfSpeech,
      );

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
      int entryID, List<String> syllableList) async {
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

  Future<PartsOfSpeechData> _getSensePartOfSpeech(int id) async {
    return (select(partsOfSpeech)..where((table) => table.id.equals(id)))
        .getSingle();
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
      //? Step 3.1: Get part of speech
      final PartsOfSpeechData partOfSpeechInst = await _getSensePartOfSpeech(
        sense.partOfSpeech,
      );

      //? Step 3.2: Get examples
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
        partOfSpeech: partOfSpeechInst.partOfSpeech,
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
  PartsOfSpeech,
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

  Future<int> _getWordID(String word) async {
    return (await (select(words)..where((table) => table.word.equals(word)))
            .getSingle())
        .id;
  }

  Future<Entry> _getEntryByWord(String word) async {
    int wordID = await _getWordID(word);
    return (select(entries)..where((table) => table.wordId.equals(wordID)))
        .getSingle();
  }

  Future<int> _insertCard(
    int entryID,
    int senseID,
    AttributeType frontType,
    AttributeType backType, {
    DateTime dueDate,
  }) async {
    final int frontID = await _createSide(entryID, senseID, frontType);
    final int backID = await _createSide(entryID, senseID, backType);
    final int cardID = await into(cards).insert(Card(
      frontId: frontID,
      backId: backID,
      dueOn: dueDate != null ? dueDate : DateTime.now(),
    ));

    await into(entryQuizCards).insert(EntryQuizCard(
      cardId: cardID,
      entryId: entryID,
    ));

    return cardID;
  }

  Future<int> _createSide(int entryID, int senseID, AttributeType type) async {
    return into(cardInfo).insert(CardInfoData(
      entryId: entryID,
      senseId: senseID,
      attributeType: ATTRIBUTE_TYPE_ID[type],
    ));
  }

  Future<bool> insertQuizCards(WordCard wordCard) async {
    final Entry entry = await _getEntryByWord(wordCard.word);
    final List<Sense> senseList = await (select(senses)
          ..where((table) => table.entryId.equals(entry.id)))
        .get();

    //? Card 1: Front = Spelling, Back = Pronunciation
    await _insertCard(
      entry.id,
      senseList[0].id,
      AttributeType.Spelling,
      AttributeType.Pronunciation,
    );

    //? Card 2: Front = Pronunciation, Back = Spelling
    await _insertCard(
      entry.id,
      senseList[0].id,
      AttributeType.Pronunciation,
      AttributeType.Spelling,
    );

    //? Card 3: Front = Spelling, Back = Syllables
    await _insertCard(
      entry.id,
      senseList[0].id,
      AttributeType.Spelling,
      AttributeType.Syllables,
    );

    int delay = 0;

    for (final Sense sense in senseList) {
      //? Card 4: Front = Definition, Back = Example
      await _insertCard(
        entry.id,
        sense.id,
        AttributeType.Definition,
        AttributeType.Example,
        dueDate: DateTime.now().add(Duration(days: delay)),
      );

      //? Card 5: Front = Example, Back = Definition
      await _insertCard(
        entry.id,
        sense.id,
        AttributeType.Example,
        AttributeType.Definition,
        dueDate: DateTime.now().add(Duration(days: delay)),
      );

      //? Card 6: Front = Example, Back = Synonyms
      await _insertCard(
        entry.id,
        sense.id,
        AttributeType.Example,
        AttributeType.Synonyms,
        dueDate: DateTime.now().add(Duration(days: delay)),
      );

      //? Card 7: Front = Example, Back = Antonyms
      await _insertCard(
        entry.id,
        sense.id,
        AttributeType.Example,
        AttributeType.Antonyms,
        dueDate: DateTime.now().add(Duration(days: delay)),
      );

      //? Card 8: Front = Example, Back = Part of speech
      await _insertCard(
        entry.id,
        sense.id,
        AttributeType.Example,
        AttributeType.PartOfSpeech,
        dueDate: DateTime.now().add(Duration(days: delay)),
      );

      delay += 1;
    }
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

  Future<Card> _getCardByID(int id) async {
    return (select(cards)..where((table) => table.id.equals(id))).getSingle();
  }

  Future<void> _deleteCardInfoWithID(int id) async {
    await (delete(cardInfo)..where((table) => table.id.equals(id))).go();
  }

  Future<void> _deleteCardDetailsWithID(int id) async {
    final Card dbCard = await _getCardByID(id);
    await _deleteCardInfoWithID(dbCard.frontId);
    await _deleteCardInfoWithID(dbCard.backId);
  }

  Future<void> _deleteCardWithID(int id) async {
    await (delete(cards)..where((table) => table.id.equals(id))).go();
  }

  Future<void> _deleteCardAndCardInfo(int cardID) async {
    await _deleteCardDetailsWithID(cardID);
    await _deleteCardWithID(cardID);
  }

  Future<bool> deleteCardsOfAnEntry(int entryID) async {
    final List<int> dbCardIDs = await _getEntryQuizCardIDs(entryID);
    for (final int id in dbCardIDs) await _deleteCardAndCardInfo(id);
    return true;
  }

  Future<void> _checkAndDeleteCardInfo(int cardInfoID, int senseID) async {
    final CardInfoData dbCardInfoData = await (select(cardInfo)
          ..where((table) => table.id.equals(cardInfoID)))
        .getSingle();
    if (dbCardInfoData.senseId == senseID)
      await _deleteCardInfoWithID(cardInfoID);
  }

  Future<bool> deleteCardOfASense(int entryID, int senseID) async {
    final List<int> dbCardIDs = await _getEntryQuizCardIDs(entryID);
    for (final int id in dbCardIDs) {
      final Card dbCard = await _getCardByID(id);
      await _checkAndDeleteCardInfo(dbCard.frontId, senseID);
      await _checkAndDeleteCardInfo(dbCard.backId, senseID);
    }
    return true;
  }

  Future<bool> deleteCardWithCardID(int cardInfoID) async {
    final CardInfoData dbCardInfo = await (select(cardInfo)
          ..where((table) => table.id.equals(cardInfoID)))
        .getSingle();
    return await deleteCardOfASense(dbCardInfo.entryId, dbCardInfo.senseId);
  }

  Future<List<Card>> _getDueCards(int no) async {
    return (select(cards)
          ..orderBy([
            (table) =>
                OrderingTerm(expression: table.dueOn, mode: OrderingMode.desc),
            (table) =>
                OrderingTerm(expression: table.level, mode: OrderingMode.asc),
            (table) => OrderingTerm(
                expression: table.isImportant, mode: OrderingMode.desc),
          ])
          ..limit(no))
        .get();
  }

  Future<CardInfoData> _getCardInfoFromID(int id) async {
    return (select(cardInfo)..where((table) => table.id.equals(id)))
        .getSingle();
  }

  Future<Entry> _getEntryFromID(int id) async {
    return (select(entries)..where((table) => table.id.equals(id))).getSingle();
  }

  Future<Word> _getWordByID(int id) async {
    return (select(words)..where((table) => table.id.equals(id))).getSingle();
  }

  Future<List<String>> _getWordSyllables(int entryID) async {
    final List<SyllableListData> dbSylList = await (select(syllableList)
          ..where((table) => table.entryId.equals(entryID)))
        .get();

    final List<String> sylList = [];
    for (final SyllableListData dbSylData in dbSylList) {
      final String syl = (await (select(syllables)
                ..where((table) => table.id.equals(dbSylData.syllableId)))
              .getSingle())
          .syllable;

      sylList.add(syl);
    }

    return sylList;
  }

  Future<Sense> _getSenseByID(int senseID) async {
    return (select(senses)..where((table) => table.id.equals(senseID)))
        .getSingle();
  }

  Future<List<String>> _getSenseExamples(int id) async {
    final List<ExampleListData> dbExampleDataList = await (select(exampleList)
          ..where((table) => table.senseId.equals(id)))
        .get();

    final List<String> outputExampleList = [];
    for (final ExampleListData dbExample in dbExampleDataList) {
      final String sentence = (await (select(examples)
                ..where((table) => table.id.equals(dbExample.exampleId)))
              .getSingle())
          .sentence;

      outputExampleList.add(sentence);
    }

    return outputExampleList;
  }

  Future<List<String>> _getSenseThesauruses(
    int id, {
    bool isAntonym = false,
  }) async {
    final List<ThesaurusListData> dbThesaurusDataList =
        await (select(thesaurusList)
              ..where((table) => table.senseId.equals(id))
              ..where((table) => table.isAntonym.equals(isAntonym)))
            .get();

    final List<String> outputList = [];
    for (final ThesaurusListData dbThesaurus in dbThesaurusDataList) {
      final String outputWord = (await (select(words)
                ..where((table) => table.id.equals(dbThesaurus.wordId)))
              .getSingle())
          .word;

      outputList.add(outputWord);
    }

    return outputList;
  }

  Future<String> _getSensePartOfSpeech(int id) async {
    return (await (select(partsOfSpeech)..where((table) => table.id.equals(id)))
            .getSingle())
        .partOfSpeech;
  }

  Future<String> _getCardSideInfo(int cardInfoID) async {
    final CardInfoData dbCardInfoData = await _getCardInfoFromID(cardInfoID);

    if (dbCardInfoData.attributeType <= 3) {
      final Entry dbEntry = await _getEntryFromID(dbCardInfoData.entryId);

      switch (dbCardInfoData.attributeType) {
        case 1:
          final Word dbWord = await _getWordByID(dbEntry.wordId);
          return dbWord.word;
        case 2:
          return dbEntry.pronunciation;
        case 3:
          final List<String> output = await _getWordSyllables(dbEntry.id);
          return output.join(' | ');
      }
    } else {
      final Sense dbSense = await _getSenseByID(dbCardInfoData.senseId);

      switch (dbCardInfoData.attributeType) {
        case 4:
          final List<String> output = await _getSenseExamples(dbSense.id);
          return output.join(' | ');
        case 5:
          return dbSense.definition;
        case 6:
          final List<String> output = await _getSenseThesauruses(dbSense.id);
          return output.join(' | ');
        case 7:
          final List<String> output = await _getSenseThesauruses(
            dbSense.id,
            isAntonym: true,
          );
          return output.join(' | ');
        case 8:
          return await _getSensePartOfSpeech(dbSense.partOfSpeech);
      }
    }

    return null;
  }

  Future<List<QuizCard>> getQuizCards({int noOfCards = 25}) async {
    final List<Card> dbCardList = await _getDueCards(noOfCards);
    final List<QuizCard> output = [];

    for (final Card dbCard in dbCardList) {
      //? Step 1: get card side information for front
      final String front = await _getCardSideInfo(dbCard.frontId);

      //? Step 2: get card side information for back
      final String back = await _getCardSideInfo(dbCard.backId);

      //? Step 3: create quiz card and add to output list
      output.add(
        QuizCard(
          id: dbCard.id,
          dueDate: dbCard.dueOn,
          isImportant: dbCard.isImportant,
          level: dbCard.level,
          front: front,
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
      final String front = await _getCardSideInfo(dbCard.frontId);
      final String back = await _getCardSideInfo(dbCard.backId);
      output.add(
        QuizCard(
          level: dbCard.level,
          dueDate: dbCard.dueOn,
          id: dbCard.id,
          isImportant: dbCard.isImportant,
          front: front,
          back: back,
        ),
      );
    }

    return output;
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
  PartsOfSpeech,
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
