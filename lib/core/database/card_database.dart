import 'dart:math';

import 'package:moor_flutter/moor_flutter.dart';
import 'package:vocab/core/entities/performance_result.dart';
import 'package:vocab/core/entities/pronunciation.dart' as PronunciationEntity;
import 'package:vocab/core/entities/syllable.dart' as SyllableEntity;
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/enums/attributes.dart';
import 'package:vocab/core/enums/mastery_levels.dart';
import 'package:vocab/core/enums/part_of_speech.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'tables.dart';

part 'package:vocab/features/show_saved_words/data/data_source/fetch_word_dao.dart';
part 'package:vocab/features/word_save/data/data_source/word_dao.dart';
part 'package:vocab/features/word_save/data/data_source/quiz_card_create_dao.dart';
part 'card_database.g.dart';

DateTime _getOnlyTimeToday() {
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    0,
    0,
    0,
    0,
    0,
  );
}

//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//
//!                                                                 DAO classes                                                                  !//
//! ============================================================================================================================================ !//
//! ============================================================================================================================================ !//

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
class QuizCardDao extends DatabaseAccessor<CardDatabase>
    with _$QuizCardDaoMixin {
  final CardDatabase cardDatabase;

  QuizCardDao(this.cardDatabase) : super(cardDatabase);

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

  Future<List<Card>> _getDueCards(int limit) async {
    final int time = (DateTime.now().millisecondsSinceEpoch / 1000).round();

    return (await customSelectQuery(
      'SELECT * FROM ${cards.actualTableName} ' +
          'WHERE ${cards.dueOn.$name} <= $time ' +
          'ORDER BY RANDOM() ' +
          'LIMIT $limit',
      readsFrom: {cards},
    ).get())
        .map((row) {
      return Card(
        id: row.readInt(cards.id.$name),
        dueOn: row.readDateTime(cards.dueOn.$name),
        level: row.readInt(cards.level.$name),
        frontId: row.readInt(cards.frontId.$name),
        backId: row.readInt(cards.backId.$name),
        isImportant: row.readBool(cards.isImportant.$name),
      );
    }).toList();
  }

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

  /// Fetches an [Entry] for [word] string.
  Future<Entry> _getEntryByWord(String word) async =>
      (await (select(words)..where((table) => table.word.equals(word))).join([
        leftOuterJoin(entries, entries.wordId.equalsExp(words.id))
      ]).getSingle())
          .readTable(entries);

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

  Future<UsageInfoData> _getUsageInformation() => (select(usageInfo)
        ..where((table) => table.date.equals(_getOnlyTimeToday())))
      .getSingle();

  Future _handleQuizUsageInfo(bool isWrong) async {
    final UsageInfoData dbUsageInfoData = await _getUsageInformation();
    final int correctNo = isWrong == false ? 1 : 0;
    final int wrongNo = 1 - correctNo;

    if (dbUsageInfoData == null) {
      await into(usageInfo).insert(UsageInfoData(
        cardsCorrect: correctNo,
        cardsWrong: wrongNo,
        cardsQuizzed: 1,
        date: _getOnlyTimeToday(),
      ));
    } else {
      await (update(usageInfo)
            ..where((table) => table.date.equals(dbUsageInfoData.date)))
          .write(UsageInfoData(
        cardsQuizzed: dbUsageInfoData.cardsQuizzed + 1,
        cardsCorrect: dbUsageInfoData.cardsCorrect + correctNo,
        cardsWrong: dbUsageInfoData.cardsWrong + wrongNo,
      ));
    }
  }

  Future<int> updateCardLevel(int cardID, int level, DateTime nextDue) async {
    await _handleQuizUsageInfo(level == 0);
    return (update(cards)..where((table) => table.id.equals(cardID))).write(
      Card(dueOn: nextDue, level: level),
    );
  }
}

@UseDao(
  tables: [
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
  ],
  queries: {
    '_getPartOfSpeechStats':
        'SELECT part_of_speech, COUNT(*) FROM senses GROUP BY part_of_speech',
    '_getUntouchedCardCount': 'SELECT COUNT(*) FROM cards WHERE level <= 0',
    '_getLearningCardCount':
        'SELECT COUNT(*) FROM cards WHERE level BETWEEN 1 AND 20',
    '_getMasteredCardCount': 'SELECT COUNT(*) FROM cards WHERE level > 20',
  },
)
class StatisticsDao extends DatabaseAccessor<CardDatabase>
    with _$StatisticsDaoMixin {
  final CardDatabase cardDatabase;

  StatisticsDao(this.cardDatabase) : super(cardDatabase);

  Future<Map<PartOfSpeechType, int>> getPartOfSpeechStatistics() async {
    final List<GetPartOfSpeechStatsResult> data = await _getPartOfSpeechStats();
    final Map<PartOfSpeechType, int> output = {};
    data.forEach((d) {
      output[ID_TO_PART_OF_SPEECH_TYPE[d.partOfSpeech]] = d.count;
    });
    return output;
  }

  Future<UsageInfoData> getGeneralUsageStats(DateTime date) async {
    final DateTime onlyDay = _getOnlyDay(date);
    final UsageInfoData dbUsageInfoData = await (select(usageInfo)
          ..where((table) => table.date.equals(onlyDay)))
        .getSingle();

    if (dbUsageInfoData == null) {
      await into(usageInfo).insert(UsageInfoData(date: onlyDay));
      return UsageInfoData(
        date: onlyDay,
        wordsDeleted: 0,
        cardsQuizzed: 0,
        wordsEdited: 0,
        wordsSaved: 0,
        wordsSearched: 0,
        cardsCorrect: 0,
        cardsWrong: 0,
      );
    }

    return dbUsageInfoData;
  }

  DateTime _getOnlyDay(DateTime date) =>
      DateTime(date.year, date.month, date.day, 0, 0, 0, 0, 0);

  Future<Map<MasteryLevels, int>> getCardLevelStatistics() async {
    final int untouchedCount = (await _getUntouchedCardCount())[0];
    final int learningCount = (await _getLearningCardCount())[0];
    final int masteredCount = (await _getMasteredCardCount())[0];

    return {
      MasteryLevels.Untouched: untouchedCount,
      MasteryLevels.Learning: learningCount,
      MasteryLevels.Mastered: masteredCount,
    };
  }

  Future<Map<DateTime, int>> getActivity() async {
    final List<UsageInfoData> list = await select(usageInfo).get();
    final Map<DateTime, int> output = {};
    list.forEach((value) => output[value.date] = value.cardsQuizzed);
    return output;
  }

  Future<Performance> getPerformanceResults(int range) async {
    final DateTime endDate = _getOnlyTimeToday().add(Duration(days: 1));
    final DateTime startDate =
        _getOnlyDay(endDate.subtract(Duration(days: range)));
    final Map<DateTime, PerformaceResult> output = {};
    int maxVal = 0, minVal = 9999999;
    final List<UsageInfoData> list = await (select(usageInfo)
          ..where((table) => table.date.isBetweenValues(startDate, endDate)))
        .get();

    list.forEach((row) {
      maxVal = max(maxVal, max(row.cardsCorrect, row.cardsWrong));
      minVal = min(minVal, min(row.cardsCorrect, row.cardsWrong));
      output[row.date] = PerformaceResult(
        totalCorrect: row.cardsCorrect,
        totalWrong: row.cardsWrong,
      );
    });

    return Performance(
      performanceMap: output,
      maxValue: maxVal,
      minValue: minVal,
    );
  }
}
// ACTUAL: 1579197600
// LOW:    1578938400
// HIGH:   1579197600
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
  QuizCardDao,
  StatisticsDao,
  FetchWordDao,
  QuizCardCreateDao,
];

//? flutter packages pub run build_runner watch --delete-conflicting-outputs

@UseMoor(tables: _CARD_DATABASE_TABLE_LIST, daos: _DAO_LIST)
class CardDatabase extends _$CardDatabase {
  CardDatabase()
      : super(
          FlutterQueryExecutor(path: 'word_card.sqlite', logStatements: true),
        );

  @override
  int get schemaVersion => 4;

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
          } else if (from == 4) {
            await m.addColumn(usageInfo, usageInfo.cardsCorrect);
            await m.addColumn(usageInfo, usageInfo.cardsWrong);
            await m.addColumn(usageInfo, usageInfo.wordsDeleted);
          }
        },
      );
}
