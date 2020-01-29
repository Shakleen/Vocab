import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/core/enums/mastery_levels.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/quiz_card/domain/repository/quiz_repository.dart';

class MarkCorrect extends UseCase<bool, Param> {
  final QuizRepository repository;

  MarkCorrect(this.repository);

  @override
  Future<Either<Failure, bool>> call(Param params) async {
    DateTime dueOn;

    if (params.level < FAMILIAR_LEVEL_START)
      dueOn = DateTime.now().add(Duration(minutes: 2));
    else if (params.level == FAMILIAR_LEVEL_START)
      dueOn = DateTime.now().add(Duration(days: 1));
    else
      dueOn = DateTime.now().add(Duration(days: 2 * params.level - 1));

    final fetchQuizCards =
        await repository.markAsCorrect(params.id, params.level, dueOn);
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
