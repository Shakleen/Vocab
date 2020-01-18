import 'package:dartz/dartz.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/error/failures.dart';

abstract class SavedWordsRepository {
  Future<Either<Failure, List<Entry>>> getWordEntries(int limit, int offset);
  Future<Either<Failure, int>> getEntrySenseCount(int entryID);
  Future<Either<Failure, int>> getEntryWord(int wordID);
}