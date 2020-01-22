import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/quiz_card/domain/repository/quiz_repository.dart';

class MarkWrong extends UseCase<bool, Param> {
  final QuizRepository repository;

  MarkWrong(this.repository);

  @override
  Future<Either<Failure, bool>> call(Param params) async {
    final fetchQuizCards =
        await repository.markAsWrong(params.id);
    return fetchQuizCards;
  }
}

class Param extends Equatable {
  final int id;

  const Param({
    @required this.id,
  });

  @override
  List<Object> get props => [id];
}
