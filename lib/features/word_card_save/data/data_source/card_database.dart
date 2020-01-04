import 'package:moor_flutter/moor_flutter.dart';
import 'package:vocab/core/entities/word_card.dart';

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
  IntColumn get syllableId =>
      integer().customConstraint('REFERENCES Syllable(id)')();
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
  IntColumn get questionId =>
      integer().customConstraint('REFERENCES CardInfo(id)')();
  IntColumn get answerId =>
      integer().customConstraint('REFERENCES CardInfo(id)')();
  IntColumn get level => integer()();
  BoolColumn get isImportant => boolean().withDefault(Constant(false))();
  DateTimeColumn get dueOn => dateTime()();
}

class CardInfo extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId => integer().customConstraint('REFERENCES Entry(id)')();
  IntColumn get senseId => integer().customConstraint('REFERENCES Sense(id)')();
  IntColumn get attributeId =>
      integer().customConstraint('REFERENCES Attribute(id)')();
}

class Attribute extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get attribute =>
      text().withLength(min: 1).customConstraint('UNIQUE')();
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
  Attribute,
];

//? flutter packages pub run build_runner watch --delete-conflicting-outputs

@UseMoor(tables: _CARD_DATABASE_TABLE_LIST)
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

//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//
//!                                                                 DAO classes                                                                  !//
//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//

@UseDao(tables: [Words])
class WordDao extends DatabaseAccessor<CardDatabase> with _$WordDaoMixin {
  final CardDatabase cardDatabase;

  WordDao(this.cardDatabase) : super(cardDatabase);

  Future<int> insertWord(Insertable<Word> entity) => into(words).insert(entity);

  Future<int> deleteWord(Insertable<Word> entity) =>
      delete(words).delete(entity);

  Future<bool> updateWord(Insertable<Word> entity) =>
      update(words).replace(entity);
}

@UseDao(tables: [Entries])
class EntryDao extends DatabaseAccessor<CardDatabase> with _$EntryDaoMixin {
  final CardDatabase cardDatabase;

  EntryDao(this.cardDatabase) : super(cardDatabase);

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

@UseDao(tables: [Cards, CardInfo])
class CardDao extends DatabaseAccessor<CardDatabase> with _$CardDaoMixin {
  final CardDatabase cardDatabase;

  CardDao(this.cardDatabase) : super(cardDatabase);

  Future insertCard(Insertable<Card> entity) => into(cards).insert(entity);

  Future deleteCard(Insertable<Card> entity) => delete(cards).delete(entity);

  Future updateCard(Insertable<Card> entity) => update(cards).replace(entity);

  Future insertCardInfo(Insertable<CardInfoData> entity) => into(cardInfo).insert(entity);

  Future deleteCardInfo(Insertable<CardInfoData> entity) => delete(cardInfo).delete(entity);

  Future updateCardInfo(Insertable<CardInfoData> entity) => update(cardInfo).replace(entity);
}

@UseDao(tables: [Attribute])
class AttributeDao extends DatabaseAccessor<CardDatabase>
    with _$AttributeDaoMixin {
  final CardDatabase cardDatabase;

  AttributeDao(this.cardDatabase) : super(cardDatabase);

  Future insertAttribute(Insertable<AttributeData> entity) =>
      into(attribute).insert(entity);

  Future deleteAttribute(Insertable<AttributeData> entity) =>
      delete(attribute).delete(entity);

  Future updateAttribute(Insertable<AttributeData> entity) =>
      update(attribute).replace(entity);
}
