import 'package:dartz/dartz.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/error/exceptions.dart';
import 'package:vocab/core/network/network_info.dart';
import 'package:vocab/features/word_card/data/data_source/remote_dictionary.dart';
import 'package:vocab/features/word_card/data/models/word_search_result_model.dart';
import 'package:vocab/features/word_card/domain/entities/word_search_result.dart';
import 'package:vocab/features/word_card/domain/repository/word_card_repository.dart';
import 'package:meta/meta.dart';

class WordCardRepositoryImpl implements WordCardRepository {
  final RemoteDictionary remoteDictionary;
  final NetworkInfo networkInfo;

  WordCardRepositoryImpl({
    @required this.remoteDictionary,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, WordSearchResult>> getWordInformation(
    String word,
  ) async {
    final bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final WordSearchResultModel result =
            await remoteDictionary.getWordDetails(word);
        return Right(result);
      } on NotFoundException {
        return Left(NotFoundFailure());
      } on InvalidFilterException {
        return Left(InvalidFilterFailure());
      } on UnauthorizedException {
        return Left(UnauthorizedFailure());
      } on ServerException {
        return Left(ServerFailure());
      } on UnknownException {
        return Left(UnknownFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
