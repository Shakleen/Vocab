import 'package:moor_flutter/moor_flutter.dart';

part 'card_database.g.dart';

//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//
//!                                                                 Tables classes                                                               !//
//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//

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

const List<Type> _WORD_DAO_TABLE_LIST = [
  Entries,
  Senses,
  Words,
  Examples,
  PartsOfSpeech,
  Syllables,
  ThesaurusList,
  ExampleList,
  SyllableList,
];

@UseDao(tables: _WORD_DAO_TABLE_LIST)
class WordDao extends DatabaseAccessor<CardDatabase> with _$WordDaoMixin {
  final CardDatabase cardDatabase;

  WordDao(this.cardDatabase) : super(cardDatabase);
}
