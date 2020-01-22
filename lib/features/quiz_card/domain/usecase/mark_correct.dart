import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/quiz_card/domain/repository/quiz_repository.dart';

class MarkCorrect extends UseCase<bool, Param> {
  final QuizRepository repository;

  MarkCorrect(this.repository);

  @override
  Future<Either<Failure, bool>> call(Param params) async {
    final fetchQuizCards =
        await repository.markAsCorrect(params.id, params.level);
    return fetchQuizCards;
  }
}

class Param extends Equatable {
  final int id, level;

  const Param({
    @required this.id,
    @required this.level,
  });

  @override
  List<Object> get props => [id, level];
}
