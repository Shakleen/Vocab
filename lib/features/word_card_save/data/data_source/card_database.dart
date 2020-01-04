import 'package:moor_flutter/moor_flutter.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';

part 'card_database.g.dart';

//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//
//!                                                                 Tables classes                                                               !//
//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//

@DataClassName('Entry')
class Entries extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get addedOn => dateTime()();
  TextColumn get pronunciation => text()();
  IntColumn get wordId => integer().customConstraint('REFERENCES Word(id)')();
}

class Senses extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId => integer().customConstraint('REFERENCES Entry(id)')();
  IntColumn get partOfSpeech =>
      integer().customConstraint('REFERENCES PartsOfSpeech(id)')();
  TextColumn get definition => text()();
}

class Words extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().withLength(min: 1).customConstraint('UNIQUE')();
}

class Examples extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sentence =>
      text().withLength(min: 1).customConstraint('UNIQUE')();
}

class PartsOfSpeech extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get partOfSpeech =>
      text().withLength(min: 1).customConstraint('UNIQUE')();
}

class Syllables extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syllable =>
      text().withLength(min: 1).customConstraint('UNIQUE')();
}

class ThesaurusList extends Table {
  IntColumn get senseId => integer().customConstraint('REFERENCES Sense(id)')();
  IntColumn get wordId => integer().customConstraint('REFERENCES Word(id)')();
  BoolColumn get isAntonym => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {senseId, wordId, isAntonym};
}

class ExampleList extends Table {
  IntColumn get senseId => integer().customConstraint('REFERENCES Sense(id)')();
  IntColumn get exampleId =>
      integer().customConstraint('REFERENCES Example(id)')();

  @override
  Set<Column> get primaryKey => {senseId, exampleId};
}

class SyllableList extends Table {
  IntColumn get entryId => integer().customConstraint('REFERENCES Entry(id)')();
  IntColumn get syllableId =>
      integer().customConstraint('REFERENCES Syllable(id)')();

  @override
  Set<Column> get primaryKey => {entryId, syllableId};
}

class Cards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get frontId =>
      integer().customConstraint('REFERENCES CardInfo(id)')();
  IntColumn get backId =>
      integer().customConstraint('REFERENCES CardInfo(id)')();
  IntColumn get level => integer().withDefault(Constant(0))();
  BoolColumn get isImportant => boolean().withDefault(Constant(false))();
  DateTimeColumn get dueOn => dateTime()();
}

class CardInfo extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId => integer().customConstraint('REFERENCES Entry(id)')();
  IntColumn get senseId => integer().customConstraint('REFERENCES Sense(id)')();
  IntColumn get attributeType => integer()();
}

//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//
//!                                                                 DAO classes                                                                  !//
//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//

@UseDao(tables: [Words])
class WordDao extends DatabaseAccessor<CardDatabase> with _$WordDaoMixin {
  final CardDatabase cardDatabase;

  WordDao(this.cardDatabase) : super(cardDatabase);

  Future<List<Word>> getAllWord() => (select(words)
        ..orderBy([(table) => OrderingTerm(expression: table.word)]))
      .get();

  Future<Word> getWord(String word) =>
      (select(words)..where((table) => table.word.equals(word))).getSingle();

  Future<int> insertWord(Insertable<Word> entity) => into(words).insert(entity);

  Future<int> deleteWord(Insertable<Word> entity) =>
      delete(words).delete(entity);

  Future<bool> updateWord(Insertable<Word> entity) =>
      update(words).replace(entity);
}

@UseDao(tables: [Entries, Words])
class EntryDao extends DatabaseAccessor<CardDatabase> with _$EntryDaoMixin {
  final CardDatabase cardDatabase;

  EntryDao(this.cardDatabase) : super(cardDatabase);

  Future<List<Entry>> getAllEntries() => (select(entries)
        ..orderBy([
          (table) =>
              OrderingTerm(expression: table.addedOn, mode: OrderingMode.desc),
        ]))
      .get();

  Future<Entry> getEntryById(int id) =>
      (select(entries)..where((table) => table.id.equals(id))).getSingle();

  Future<Entry> getEntryByWord(String word) async {
    final Word getWord = await (select(words)
          ..where((table) => table.word.equals(word)))
        .getSingle();
    return (select(entries)..where((table) => table.id.equals(getWord.id)))
        .getSingle();
  }

  Future<int> insertEntry(Insertable<Entry> entity) =>
      into(entries).insert(entity);

  Future<int> deleteEntry(Insertable<Entry> entity) =>
      delete(entries).delete(entity);

  Future<bool> updateEntry(Insertable<Entry> entity) =>
      update(entries).replace(entity);
}

@UseDao(tables: [Syllables, SyllableList])
class SyllableDao extends DatabaseAccessor<CardDatabase>
    with _$SyllableDaoMixin {
  final CardDatabase cardDatabase;

  SyllableDao(this.cardDatabase) : super(cardDatabase);

  Future<int> insertSyllable(Insertable<Syllable> entity) =>
      into(syllables).insert(entity);

  Future<int> deleteSyllable(Insertable<Syllable> entity) =>
      delete(syllables).delete(entity);

  Future<bool> updateSyllable(Insertable<Syllable> entity) =>
      update(syllables).replace(entity);

  Future insertSyllableId(Insertable<SyllableListData> entity) =>
      into(syllableList).insert(entity);

  Future deleteSyllableId(Insertable<SyllableListData> entity) =>
      delete(syllableList).delete(entity);

  Future updateSyllableId(Insertable<SyllableListData> entity) =>
      update(syllableList).replace(entity);
}

@UseDao(tables: [PartsOfSpeech])
class PartsOfSpeechDao extends DatabaseAccessor<CardDatabase>
    with _$PartsOfSpeechDaoMixin {
  final CardDatabase cardDatabase;

  PartsOfSpeechDao(this.cardDatabase) : super(cardDatabase);

  Future<int> insertPartOfSpeech(Insertable<PartsOfSpeechData> entity) =>
      into(partsOfSpeech).insert(entity);

  Future<int> deletePartOfSpeech(Insertable<PartsOfSpeechData> entity) =>
      delete(partsOfSpeech).delete(entity);

  Future<bool> updatePartOfSpeech(Insertable<PartsOfSpeechData> entity) =>
      update(partsOfSpeech).replace(entity);
}

@UseDao(tables: [Senses])
class SenseDao extends DatabaseAccessor<CardDatabase> with _$SenseDaoMixin {
  final CardDatabase cardDatabase;

  SenseDao(this.cardDatabase) : super(cardDatabase);

  Future<int> insertSense(Insertable<Sense> entity) =>
      into(senses).insert(entity);

  Future<int> deleteSense(Insertable<Sense> entity) =>
      delete(senses).delete(entity);

  Future<bool> updateSense(Insertable<Sense> entity) =>
      update(senses).replace(entity);
}

@UseDao(tables: [ThesaurusList])
class ThesaurusDao extends DatabaseAccessor<CardDatabase>
    with _$ThesaurusDaoMixin {
  final CardDatabase cardDatabase;

  ThesaurusDao(this.cardDatabase) : super(cardDatabase);

  Future insertThesaurus(Insertable<ThesaurusListData> entity) =>
      into(thesaurusList).insert(entity);

  Future deleteThesaurus(Insertable<ThesaurusListData> entity) =>
      delete(thesaurusList).delete(entity);

  Future updateThesaurus(Insertable<ThesaurusListData> entity) =>
      update(thesaurusList).replace(entity);
}

@UseDao(tables: [Examples, ExampleList])
class ExampleDao extends DatabaseAccessor<CardDatabase> with _$ExampleDaoMixin {
  final CardDatabase cardDatabase;

  ExampleDao(this.cardDatabase) : super(cardDatabase);

  Future<int> insertExample(Insertable<Example> entity) =>
      into(examples).insert(entity);

  Future<int> deleteExample(Insertable<Example> entity) =>
      delete(examples).delete(entity);

  Future<bool> updateExample(Insertable<Example> entity) =>
      update(examples).replace(entity);

  Future insertExampleId(Insertable entity) => into(exampleList).insert(entity);

  Future deleteExampleId(Insertable entity) =>
      delete(exampleList).delete(entity);

  Future updateExampleId(Insertable entity) =>
      update(exampleList).replace(entity);
}

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
  Cards,
  CardInfo,
])
class WordTotalDao extends DatabaseAccessor<CardDatabase>
    with _$WordTotalDaoMixin {
  final CardDatabase cardDatabase;

  WordTotalDao(this.cardDatabase) : super(cardDatabase);

  Future<int> _getWordID(String word) async {
    return (await (select(words)..where((table) => table.word.equals(word)))
            .getSingle())
        .id;
  }

  Future<Entry> _getEntryByWord(String word) async {
    int wordID = await _getWordID(word);
    return (select(entries)..where((table) => table.id.equals(wordID)))
        .getSingle();
  }

  Future<int> _getWordIDofExistingOrNew(String word) async {
    int wordID = -1;

    try {
      wordID = await into(words).insert(Word(word: word));
    } catch (e) {
      print(e);
      wordID = await _getWordID(word);
    }

    return wordID;
  }

  Future<int> _getSyllableIDofExistingOrNew(String syllable) async {
    int syllableID = -1;

    try {
      syllableID = await into(syllables).insert(Syllable(syllable: syllable));
    } catch (e) {
      syllableID = (await (select(syllables)
                ..where((table) => table.syllable.equals(syllable)))
              .getSingle())
          .id;
    }

    return syllableID;
  }

  Future<int> _getPartOfSpeechIDofExistingOrNew(String partOfSpeech) async {
    int partOfSpeechID = -1;

    try {
      partOfSpeechID = await into(partsOfSpeech).insert(PartsOfSpeechData(
        partOfSpeech: partOfSpeech,
      ));
    } catch (e) {
      partOfSpeechID = (await (select(partsOfSpeech)
                ..where((table) => table.partOfSpeech.equals(partOfSpeech)))
              .getSingle())
          .id;
    }

    return partOfSpeechID;
  }

  Future<int> _getExampleIDofExistingOrNew(String example) async {
    int exampleID = -1;

    try {
      exampleID = await into(examples).insert(Example(sentence: example));
    } catch (e) {
      exampleID = (await (select(examples)
                ..where((table) => table.sentence.equals(example)))
              .getSingle())
          .id;
    }

    return exampleID;
  }

  Future<bool> insertWordCard(WordCard wordCard) async {
    //? Step 1: Store word into Words table.
    int wordID = await _getWordIDofExistingOrNew(wordCard.word);

    //? Step 2: Store date, pronunciation and wordID into Words table
    int entryID = await into(entries).insert(Entry(
      wordId: wordID,
      addedOn: DateTime.now(),
      pronunciation: wordCard.pronunciation.all,
    ));

    //? Step 3: Store and link each syllable with entry.
    wordCard.syllables.list.forEach((String s) async {
      //? Step 3.1: Store syllable part into Syllable table
      int syllableID = await _getSyllableIDofExistingOrNew(s);

      //? Step 3.2: Link entries and syllable part using SyllableList table
      await into(syllableList).insert(SyllableListData(
        entryId: entryID,
        syllableId: syllableID,
      ));
    });

    //? Step 4: Store sense and related details
    wordCard.detailList.forEach((WordCardDetails wordCardDetails) async {
      //? Step 4.1: Store part of speech data or get ID if already exists
      int partOfSpeechID = await _getPartOfSpeechIDofExistingOrNew(
        wordCardDetails.partOfSpeech,
      );

      //? Step 4.2: Store sense into Sense table
      int senseID = await into(senses).insert(Sense(
        definition: wordCardDetails.definition,
        entryId: entryID,
        partOfSpeech: partOfSpeechID,
      ));

      //? Step 4.3: Store sense examples into example table
      wordCardDetails.exampleList.forEach((String example) async {
        int exampleID = await _getExampleIDofExistingOrNew(example);
        await into(exampleList)
            .insert(ExampleListData(exampleId: exampleID, senseId: senseID));
      });

      //? Step 4.4: Store synonyms into thesaurus table
      wordCardDetails.synonymList.forEach((String synonym) async {
        int synonymWordID = await _getWordIDofExistingOrNew(synonym);

        await into(thesaurusList)
            .insert(ThesaurusListData(senseId: senseID, wordId: synonymWordID));
      });

      //? Step 4.5: Store antonyms into thesaurus table
      wordCardDetails.antonymList.forEach((String antonym) async {
        int antonymWordID = await _getWordIDofExistingOrNew(antonym);

        await into(thesaurusList).insert(ThesaurusListData(
          senseId: senseID,
          wordId: antonymWordID,
          isAntonym: true,
        ));
      });
    });

    return true;
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
    return into(cards).insert(Card(
      frontId: frontID,
      backId: backID,
      dueOn: dueDate != null ? dueDate : DateTime.now(),
    ));
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

    senseList.forEach((Sense sense) async {
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
    });
  }
}

@UseDao(tables: [Cards, CardInfo])
class CardDao extends DatabaseAccessor<CardDatabase> with _$CardDaoMixin {
  final CardDatabase cardDatabase;

  CardDao(this.cardDatabase) : super(cardDatabase);

  Future insertCard(Insertable<Card> entity) => into(cards).insert(entity);

  Future deleteCard(Insertable<Card> entity) => delete(cards).delete(entity);

  Future updateCard(Insertable<Card> entity) => update(cards).replace(entity);

  Future insertCardInfo(Insertable<CardInfoData> entity) =>
      into(cardInfo).insert(entity);

  Future deleteCardInfo(Insertable<CardInfoData> entity) =>
      delete(cardInfo).delete(entity);

  Future updateCardInfo(Insertable<CardInfoData> entity) =>
      update(cardInfo).replace(entity);
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
  Cards,
  CardInfo,
];

const List<Type> _CARD_DATABASE_DAO_LIST = [
  WordDao,
  EntryDao,
  SyllableDao,
  PartsOfSpeechDao,
  SenseDao,
  ThesaurusDao,
  ExampleDao,
  CardDao,
];

//? flutter packages pub run build_runner watch --delete-conflicting-outputs

@UseMoor(tables: _CARD_DATABASE_TABLE_LIST, daos: _CARD_DATABASE_DAO_LIST)
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
