import 'package:dartz/dartz.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/word_save/domain/repository/word_save_repository.dart';

class WordSaveRepositoryImpl implements WordSaveRepository {
  final WordDao wordDao;

  WordSaveRepositoryImpl(CardDatabase cardDatabase)
      : this.wordDao = cardDatabase.wordDao;

  @override
  Future<Either<Failure, bool>> insertWordDetails(WordCard wordCard) async {
    try {
      final bool result = await wordDao.insertWordCard(wordCard);
      return Right(result);
    } on Exception {
      return Left(DatabaseInsertionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> updateWordDetails(WordCard wordCard) async {
    try {
      final bool result = await wordDao.updateWordCard(wordCard);
      return Right(result);
    } on Exception {
      return Left(DatabaseUpdateFailure());
    }
  }
}
