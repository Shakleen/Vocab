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
part 'package:vocab/features/quiz_card/data/data_source/quiz_dao.dart';
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
        'SELECT COUNT(*) FROM cards WHERE level BETWEEN 1 AND 10',
    '_getFamiliarCardCount':
        'SELECT COUNT(*) FROM cards WHERE level BETWEEN 11 AND 24',
    '_getMasteredCardCount': 'SELECT COUNT(*) FROM cards WHERE level > 24',
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
    final int familiarCount = (await _getFamiliarCardCount())[0];
    final int masteredCount = (await _getMasteredCardCount())[0];

    return {
      MasteryLevels.Untouched: untouchedCount,
      MasteryLevels.Learning: learningCount,
      MasteryLevels.Familiar: familiarCount,
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
  QuizDao,
];

//? flutter packages pub run build_runner watch --delete-conflicting-outputs

@UseMoor(tables: _CARD_DATABASE_TABLE_LIST, daos: _DAO_LIST)
class CardDatabase extends _$CardDatabase {
  CardDatabase()
      : super(
          FlutterQueryExecutor(path: 'word_card.sqlite', logStatements: true),
        );

  @override
  int get schemaVersion => 12;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (OpeningDetails openingDetails) async {
          await this.customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (Migrator m) {
          return m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 12) {
            await m.issueCustomQuery("PRAGMA foreign_keys=off;");
            await m.issueCustomQuery("BEGIN TRANSACTION;");
            await m.issueCustomQuery(
              "ALTER TABLE ${syllableList.actualTableName} RENAME TO ${syllableList.actualTableName}B;",
            );
            await m.issueCustomQuery(
              "CREATE TABLE ${syllableList.actualTableName} (" +
                  "${syllableList.entryId.$name} INTEGER, " +
                  "${syllableList.syllableId.$name} INTEGER, " +
                  "FOREIGN KEY(${syllableList.syllableId.$name}) REFERENCES ${syllables.actualTableName}(${syllables.id.$name}), " +
                  "FOREIGN KEY(${syllableList.entryId.$name}) REFERENCES ${entries.actualTableName}(${entries.id.$name})" +
                  ");",
            );
            await m.issueCustomQuery(
              "INSERT INTO ${syllableList.actualTableName} SELECT * FROM ${syllableList.actualTableName}B;",
            );
            await m.issueCustomQuery(
              "DROP TABLE ${syllableList.actualTableName}B;",
            );
            await m.issueCustomQuery("COMMIT;");
            await m.issueCustomQuery("PRAGMA foreign_keys=on;");
          }
        },
      );
}
