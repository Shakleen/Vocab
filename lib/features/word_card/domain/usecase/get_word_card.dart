import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:vocab/features/word_card/domain/entities/word_card.dart';
import 'package:vocab/features/word_card/domain/repository/word_card_repository.dart';

class GetWordCard extends UseCase<WordCard, Param> {
  final WordCardRepository repository;

  GetWordCard({@required this.repository});

  @override
  Future<Either<Failure, WordCard>> call(Param params) {
    return null;
  }
}

class Param extends Equatable {
  final String queryWord;

  const Param({@required this.queryWord});

  @override
  List<Object> get props => [queryWord];
}