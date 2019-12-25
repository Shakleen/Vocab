import 'package:dartz/dartz.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/query_word/data/data_source/word_entry_data_source.dart';
import 'package:vocab/features/query_word/data/models/retrieve_entry_model.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';
import 'package:vocab/features/query_word/domain/repository/query_word_repository.dart';
import 'package:vocab/core/network/network_info.dart';
import 'package:meta/meta.dart';

class QueryWordRepositoryImpl implements QueryWordRepository {
  final WordEntryDataSource source;
  final NetworkInfo networkChecker;

  QueryWordRepositoryImpl({@required this.source, @required this.networkChecker});

  @override
  Future<Either<Failure, RetrieveEntry>> getWordEntry(String word) async {
    if (await networkChecker.isConnected) {
      final RetrieveEntryModel wordEntry = await source.getWordEntry(word);
      return Right(wordEntry);
    }
    else {
      return Left(DeviceOfflineFailure());
    }
  }
}
