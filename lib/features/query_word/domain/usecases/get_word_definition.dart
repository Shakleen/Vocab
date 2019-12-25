import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';
import 'package:vocab/features/query_word/domain/repository/query_word_repository.dart';
import 'package:meta/meta.dart';

class GetWordDefinition extends UseCase<RetrieveEntry, Param> {
  final QueryWordRepository repository;

  GetWordDefinition({@required this.repository});

  @override
  Future<Either<Failure, RetrieveEntry>> call(Param params) {
    return repository.getWordEntry(params.queryWord);
  }
}

class Param extends Equatable {
  final String queryWord;

  const Param({@required this.queryWord});

  @override
  List<Object> get props => [queryWord];
}