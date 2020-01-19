import 'package:dartz/dartz.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/word_save/domain/repository/saved_words_repository.dart';

class SavedWordRepositoryImpl extends SavedWordsRepository {
  final CardDatabase cardDatabase;

  SavedWordRepositoryImpl(this.cardDatabase);

  @override
  Future<Either<Failure, int>> getEntrySenseCount(int entryID) async {
    try {
      return Right(await cardDatabase.wordDao.getEntrySenseCount(entryID));
    } on Exception {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getEntryWord(int wordID) async {
    try {
      final Word dbWord = await cardDatabase.wordDao.getEntryWordByID(wordID);
      return Right(dbWord.word);
    } on Exception {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Entry>>> getWordEntries(
      int limit, int offset) async {
    try {
      final List<Entry> result =
          await cardDatabase.wordDao.getWordEntries(limit, offset);

      return Right(result);
    } on Exception {
      return Left(DatabaseFailure());
    }
  }
}
