import 'package:moor_flutter/moor_flutter.dart';

part 'card_database.g.dart';

@DataClassName('Entry')
class Entries extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  DateTimeColumn get addedOn => dateTime()();
  TextColumn get pronunciation => text()();
  IntColumn get syllableId => integer()(); // TODO: FK
  IntColumn get wordId => integer()(); // TODO: FK
}

@DataClassName('Sense')
class Senses extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  IntColumn get entryId => integer()(); // TODO: FK
  IntColumn get partOfSpeech => integer()(); // TODO: FK
  TextColumn get definition => text()();
}

@DataClassName('Word')
class Words extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  TextColumn get word => text().withLength(min: 1)();
}

@DataClassName('Example')
class Examples extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  TextColumn get sentence => text().withLength(min: 1)();
}

@DataClassName('PartsOfSpeech')
class PartsOfSpeech extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  TextColumn get partOfSpeech => text().withLength(min: 1)();
}

@DataClassName('Syllable')
class Syllables extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  TextColumn get syllable => text().withLength(min: 1)();
}

@DataClassName('ThesaurusList')
class ThesaurusList extends Table {
  IntColumn get senseId => integer()(); // TODO: FK
  IntColumn get wordId => integer()(); // TODO: FK
  BoolColumn get isAntonym => boolean().withDefault(Constant(false))();
}

@DataClassName('ExampleList')
class ExampleList extends Table {
  IntColumn get senseId => integer()(); // TODO: FK
  IntColumn get exampleId => integer()(); // TODO: FK
}

@DataClassName('SyllableList')
class SyllableList extends Table {
  IntColumn get entryId => integer()(); // TODO: FK
  IntColumn get syllableId => integer()(); // TODO: FK
}

@DataClassName('Card')
class Cards extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  IntColumn get questionId => integer()(); // TODO: FK
  IntColumn get answerId => integer()(); // TODO: FK
  IntColumn get level => integer()();
  BoolColumn get isImportant => boolean().withDefault(Constant(false))();
  DateTimeColumn get dueOn => dateTime()();
}

@DataClassName('CardInfo')
class CardInfo extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  IntColumn get entryId => integer()(); // TODO: FK
  IntColumn get senseId => integer()(); // TODO: FK
  IntColumn get attributeId => integer()(); // TODO: FK
}

@DataClassName('Attribute')
class Attribute extends Table {
  IntColumn get id => integer().autoIncrement()(); // TODO: PK
  TextColumn get attribute => text().withLength(min: 1)();
}

const List<Type> _tableList = [
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

//? flutter packages pub run build_runner watch

@UseMoor(tables: _tableList)
class CardDatabase extends _$CardDatabase {
  CardDatabase()
      : super(
          FlutterQueryExecutor(path: 'word_card.sqlite', logStatements: true),
        );

  @override
  int get schemaVersion => 1;
}
