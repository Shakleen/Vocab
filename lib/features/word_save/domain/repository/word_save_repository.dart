import 'package:dartz/dartz.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/error/failures.dart';

abstract class WordSaveRepository {
  Future<Either<Failure, bool>> insertWordDetails(WordCard wordCard);
  Future<Either<Failure, bool>> updateWordDetails(WordCard wordCard);
  Future<Either<Failure, bool>> createQuizCards(WordCard wordCard);
}