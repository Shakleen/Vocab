import 'package:moor_flutter/moor_flutter.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/entities/syllable.dart' as SyllableEntity;
import 'package:vocab/core/entities/pronunciation.dart' as PronunciationEntity;
import 'package:sqflite/src/exception.dart';

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

class Cards extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get frontId =>
      integer().customConstraint('REFERENCES card_info(id)')();
  IntColumn get backId =>
      integer().customConstraint('REFERENCES card_info(id)')();
  IntColumn get level => integer().withDefault(Constant(0))();
  BoolColumn get isImportant => boolean().withDefault(Constant(false))();
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
      return into(entries).insert(
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
    return (select(entries)..where((table) => table.id.equals(wordID)))
        .getSingle();
  }

  Future<int> _getExistingOrNewSyllableID(String inputSyllable) async {
    final Syllable searchSyllable = await (select(syllables)
          ..where((table) => table.syllable.equals(inputSyllable)))
        .getSingle();

    if (searchSyllable != null) {
      return searchSyllable.id;
    } else {
      return into(syllables).insert(Syllable(syllable: inputSyllable));
    }
  }

  Future<int> _getExistingOrNewPartOfSpeechID(String partOfSpeech) async {
    final PartsOfSpeechData pos = await (select(partsOfSpeech)
          ..where((table) => table.partOfSpeech.equals(partOfSpeech)))
        .getSingle();

    if (pos != null) {
      return pos.id;
    } else {
      return into(partsOfSpeech).insert(
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
      return into(examples).insert(Example(sentence: inputExample));
    }
  }

  Future<void> _linkEntryAndSyllable(int entryID, int syllableID) async {
    into(syllableList).insert(
      SyllableListData(entryId: entryID, syllableId: syllableID),
    );
  }

  Future<void> _linkSenseAndExample(int exampleID, int senseID) async {
    into(exampleList).insert(
      ExampleListData(exampleId: exampleID, senseId: senseID),
    );
  }

  Future<void> _linkSenseAndThesaurus(
    int senseID,
    int wordID, {
    bool isAntonym = false,
  }) async {
    into(thesaurusList).insert(
      ThesaurusListData(
        senseId: senseID,
        wordId: wordID,
        isAntonym: isAntonym,
      ),
    );
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
    wordCard.syllables.list.forEach((String s) async {
      final int syllableID = await _getExistingOrNewSyllableID(s);
      _linkEntryAndSyllable(entryID, syllableID);
    });

    //? Step 4: Dealing with senses list data
    wordCard.detailList.forEach((WordCardDetails wordCardDetails) async {
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
      wordCardDetails.exampleList.forEach((String example) async {
        final int exampleID = await _getExistingOrNewExampleID(example);
        _linkSenseAndExample(exampleID, senseID);
      });

      //? Step 4.4: Store synonyms into thesaurus table
      //? ==============================================================
      // Same as syllables
      wordCardDetails.synonymList.forEach((String synonym) async {
        final int synonymWordID = await _getExistingOrNewWordID(synonym);
        _linkSenseAndThesaurus(senseID, synonymWordID);
      });

      //? Step 4.5: Store antonyms into thesaurus table
      //? ==============================================================
      // Same as syllables
      wordCardDetails.antonymList.forEach((String antonym) async {
        final int antonymWordID = await _getExistingOrNewWordID(antonym);
        _linkSenseAndThesaurus(senseID, antonymWordID, isAntonym: true);
      });
    });

    return true;
  }

  Future<List<String>> _makeThesaurusList(
      {int senseID, bool isAntonym = false}) async {
    final List<String> result = [];
    final List<ThesaurusListData> list =
        await ((select(thesaurusList)..where((table) => table.senseId.equals(senseID)))
              ..where((table) => table.isAntonym.equals(isAntonym)))
            .get();
    list.forEach((ThesaurusListData data) async {
      final String e = (await (select(words)
                ..where((table) => table.id.equals(data.wordId)))
              .getSingle())
          .word;
      result.add(e);
    });

    return result;
  }

  Future<WordCard> getWordCard(String word) async {
    final List<String> sylList = [];
    final List<WordCardDetails> detailsList = [];

    //? Step 1: Get entry level details.
    final Entry entry = await _getEntryByWord(word);

    //? Step 2: get syllables
    final List<SyllableListData> sylDataList = await (select(syllableList)
          ..where((table) => table.entryId.equals(entry.id)))
        .get();
    sylDataList.forEach((SyllableListData sylListData) async {
      final String syl = (await (select(syllables)
                ..where((table) => table.id.equals(sylListData.syllableId)))
              .getSingle())
          .syllable;
      sylList.add(syl);
    });

    //? Step 3: get sense level details.
    final List<Sense> senseList = await (select(senses)
          ..where((table) => table.entryId.equals(entry.id)))
        .get();

    senseList.forEach((Sense sense) async {
      final List<String> result_exampleList = [];

      //? Step 3.1: Get part of speech
      String pos = (await (select(partsOfSpeech)
                ..where((table) => table.id.equals(sense.partOfSpeech)))
              .getSingle())
          .partOfSpeech;

      //? Step 3.2: Get examples
      final List<ExampleListData> table_ExampleDataList =
          await (select(exampleList)
                ..where((table) => table.senseId.equals(sense.id)))
              .get();
      table_ExampleDataList.forEach((ExampleListData data) async {
        final String e = (await (select(examples)
                  ..where((table) => table.id.equals(data.exampleId)))
                .getSingle())
            .sentence;
        result_exampleList.add(e);
      });

      detailsList.add(WordCardDetails(
        synonymList: await _makeThesaurusList(senseID: sense.id),
        antonymList:
            await _makeThesaurusList(senseID: sense.id, isAntonym: true),
        definition: sense.definition,
        exampleList: result_exampleList,
        partOfSpeech: pos,
      ));
    });

    return WordCard(
      word: word,
      pronunciation: PronunciationEntity.Pronunciation(
        all: entry.pronunciation,
      ),
      syllables: SyllableEntity.Syllable(
        count: sylList.length,
        list: sylList,
      ),
      detailList: detailsList,
    );
  }

  Future<List<String>> getSavedWords() async {
    return (await (select(entries).join(
      [
        leftOuterJoin(words, words.id.equalsExp(entries.id)),
      ],
    )).get())
        .map(
          (row) => row.readTable(words).word,
        )
        .toList();
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
    return (select(entries)..where((table) => table.id.equals(wordID)))
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
