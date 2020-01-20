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
class QuizCardCreateDao extends DatabaseAccessor<CardDatabase>
    with _$QuizCardCreateDaoMixin {
  final CardDatabase cardDatabase;

  QuizCardCreateDao(this.cardDatabase) : super(cardDatabase);

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
      final int exampleCount = (await customSelectQuery(
        'SELECT COUNT(*) FROM ${exampleList.actualTableName} ' +
            'WHERE ${exampleList.senseId.$name} = ${sense.id};',
        readsFrom: {exampleList},
      ).getSingle())
          .readInt('COUNT(*)');

      if (exampleCount > 0) {
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

        final int synonymCount = (await customSelectQuery(
          'SELECT COUNT(*) FROM ${thesaurusList.actualTableName} ' +
              'WHERE ${thesaurusList.senseId.$name} = ${sense.id} AND is_antonym = 0;',
          readsFrom: {thesaurusList},
        ).getSingle())
            .readInt('COUNT(*)');

        if (synonymCount > 0) {
          //? Card 6: Front = Example, Back = Synonyms
          await _insertCard(
            entryID: dbEntry.id,
            senseID: sense.id,
            frontType: AttributeType.Example,
            backType: AttributeType.Synonyms,
            dueDate: DateTime.now().add(Duration(days: delay)),
          );
        }

        final int antonymCount = (await customSelectQuery(
          'SELECT COUNT(*) FROM ${thesaurusList.actualTableName} ' +
              'WHERE ${thesaurusList.senseId.$name} = ${sense.id} AND is_antonym = 1;',
          readsFrom: {thesaurusList},
        ).getSingle())
            .readInt('COUNT(*)');

        if (antonymCount > 0) {
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
}
