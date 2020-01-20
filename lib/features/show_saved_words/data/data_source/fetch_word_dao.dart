part of 'package:vocab/core/database/card_database.dart';

@UseDao(tables: [
  Entries,
  Senses,
  Words,
])
class FetchWordDao extends DatabaseAccessor<CardDatabase>
    with _$FetchWordDaoMixin {
  final CardDatabase cardDatabase;

  FetchWordDao(this.cardDatabase) : super(cardDatabase);

  Future<List<Entry>> getWordEntries(int limit, int offset) async =>
      (await ((select(words)
                    ..orderBy([
                      (table) => OrderingTerm(
                            expression: table.word,
                            mode: OrderingMode.asc,
                          )
                    ]))
                  .join(
                      [innerJoin(entries, entries.wordId.equalsExp(words.id))])
                    ..limit(limit, offset: offset))
              .get())
          .map((table) => table.readTable(entries))
          .toList();

  Future<Word> getEntryWordByID(int wordID) async =>
      (select(words)..where((table) => table.id.equals(wordID))).getSingle();

  Future<int> getEntrySenseCount(int entryID) async => (await customSelectQuery(
        'SELECT COUNT(*) FROM ${senses.actualTableName} ' +
            'WHERE ${senses.entryId.$name} = $entryID;',
        readsFrom: {senses},
      ).getSingle())
          .readInt('COUNT(*)');
}
