import 'package:dartz/dartz.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/enums/attributes.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:vocab/features/quiz_card/domain/repository/quiz_repository.dart';

class QuizRepositoyImpl implements QuizRepository {
  final QuizDao quizDao;

  QuizRepositoyImpl(CardDatabase cardDatabase)
      : this.quizDao = cardDatabase.quizDao;

  @override
  Future<Either<Failure, List<QuizCard>>> getQuizCardsForTodaysWords() async {
    try {
      final List<Card> dbCardList = await quizDao.getCardsAddedToday();

      if (dbCardList.isNotEmpty) {
        final List<QuizCard> output = await _makeQuizCards(dbCardList);
        return output.isNotEmpty ? Right(output) : Left(EmptyListFailure());
      } else {
        return Left(EmptyListFailure());
      }
    } on Exception {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<QuizCard>>> getQuizCards(int limit) async {
    try {
      final List<Card> dbCardList = await quizDao.getQuizCards(limit);

      if (dbCardList.isNotEmpty) {
        final List<QuizCard> output = await _makeQuizCards(dbCardList);
        return output.isNotEmpty ? Right(output) : Left(EmptyListFailure());
      } else {
        return Left(EmptyListFailure());
      }
    } on Exception {
      return Left(DatabaseFailure());
    }
  }

  Future<List<QuizCard>> _makeQuizCards(List<Card> dbCardList) async {
    final List<QuizCard> output = [];

    for (final Card dbCard in dbCardList) {
      if (dbCard == null) continue;

      //? Step 1: get card side information for front
      final CardInfoData dbFrontCardInfo =
          await quizDao.getCardInfoFromID(dbCard.frontId);
      final String front = await quizDao.getCardSideInfo(dbFrontCardInfo);

      //? Step 2: get card side information for back
      final CardInfoData dbBackCardInfo =
          await quizDao.getCardInfoFromID(dbCard.backId);
      final String back = await quizDao.getCardSideInfo(dbBackCardInfo);

      //? Step 3: Get the word
      final String word = await quizDao.getWordFromCardID(dbCard.id);

      //? Step 4: create quiz card and add to output list
      output.add(
        QuizCard(
          word: word,
          id: dbCard.id,
          dueDate: dbCard.dueOn,
          isImportant: dbCard.isImportant,
          level: dbCard.level,
          frontType: ID_TO_ATTRIBUTE_TYPE[dbFrontCardInfo.attributeType],
          front: front,
          backType: ID_TO_ATTRIBUTE_TYPE[dbBackCardInfo.attributeType],
          back: back,
        ),
      );
    }
    return output;
  }

  @override
  Future<Either<Failure, bool>> markAsCorrect(
      int cardID, int level, DateTime dueOn) async {
    try {
      final int affected = await quizDao.updateCardLevel(cardID, level, dueOn);
      return Right(affected == 1);
    } on Exception {
      Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> markAsImportant(int cardID, bool status) async {
    try {
      final int affected = await quizDao.toggleCardImportance(cardID, status);
      return Right(affected == 1);
    } on Exception {
      Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> markAsWrong(int cardID) async {
    try {
      final DateTime nextDue = DateTime.now().add(Duration(minutes: 1));
      final int affected = await quizDao.updateCardLevel(cardID, 0, nextDue);
      return Right(affected == 1);
    } on Exception {
      Left(DatabaseFailure());
    }
  }
}
