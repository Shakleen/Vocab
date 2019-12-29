import 'package:dartz/dartz.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/word_card/domain/entities/word_search_result.dart';

abstract class WordCardRepository {
  Future<Either<Failure, WordSearchResult>> getWordInformation(String word);
}