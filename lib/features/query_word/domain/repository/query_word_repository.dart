import 'package:dartz/dartz.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

abstract class QueryWordRepository {
  Future<Either<Failure, RetrieveEntry>> getWordEntry(String word);
}