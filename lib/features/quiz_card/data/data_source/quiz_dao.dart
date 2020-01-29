part of 'package:vocab/core/database/card_database.dart';

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
class QuizDao extends DatabaseAccessor<CardDatabase> with _$QuizDaoMixin {
  final CardDatabase cardDatabase;

  QuizDao(this.cardDatabase) : super(cardDatabase);

  Future<List<Card>> getCardsAddedToday() async {
    return (await (select(entries)
              ..where((table) => table.addedOn.equals(_getOnlyTimeToday())))
            .join([
      leftOuterJoin(entryQuizCards, entryQuizCards.entryId.equalsExp(entries.id)),
      leftOuterJoin(cards, cards.id.equalsExp(entryQuizCards.cardId)),
    ]).get())
        .map((row) {
      final Card card = row.readTable(cards);
      if (card.level == 0) return card;
      else if (card.dueOn.isBefore(DateTime.now())) return card;
      else return null;
    }).toList();
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

  Future<List<Card>> getNewQuizCards(int limit, int time) async =>
      (await customSelectQuery(
        'SELECT * FROM ${cards.actualTableName} ' +
            'WHERE ${cards.dueOn.$name} <= $time AND ' +
            '${cards.level.$name} <= 1 ' +
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

  Future<List<Card>> getOldQuizCards(int limit, int time) async =>
      (await customSelectQuery(
        'SELECT * FROM ${cards.actualTableName} ' +
            'WHERE ${cards.dueOn.$name} <= $time AND ' +
            '${cards.level.$name} > 1 ' +
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

  Future<CardInfoData> getCardInfoFromID(int cardInfoID) async =>
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

  Future<String> getCardSideInfo(CardInfoData dbCardInfoData) async {
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

  Future<String> getWordFromCardID(int cardID) async =>
      (await (select(cards)..where((table) => table.id.equals(cardID))).join([
        leftOuterJoin(
            entryQuizCards, entryQuizCards.cardId.equalsExp(cards.id)),
        leftOuterJoin(entries, entries.id.equalsExp(entryQuizCards.entryId)),
        leftOuterJoin(words, words.id.equalsExp(entries.wordId)),
      ]).getSingle())
          .readTable(words)
          .word;

  Future<Card> _getCardByID(int id) async =>
      (select(cards)..where((table) => table.id.equals(id))).getSingle();

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
          await getCardInfoFromID(dbCard.frontId);
      final String front = await getCardSideInfo(dbFrontCardInfo);

      final CardInfoData dbBackCardInfo =
          await getCardInfoFromID(dbCard.backId);
      final String back = await getCardSideInfo(dbBackCardInfo);
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
