import 'package:dartz/dartz.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';

abstract class QuizRepository {
  Future<Either<Failure, List<QuizCard>>> getQuizCards(int limit);
  Future<Either<Failure, List<QuizCard>>> getQuizCardsForTodaysWords();
  Future<Either<Failure, bool>> markAsCorrect(int cardID, int level, DateTime dueOn);
  Future<Either<Failure, bool>> markAsWrong(int cardID);
  Future<Either<Failure, bool>> markAsImportant(int cardID, bool status);
}
