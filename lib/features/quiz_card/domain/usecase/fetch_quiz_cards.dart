import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:vocab/features/quiz_card/domain/repository/quiz_repository.dart';

class FetchQuizCards extends UseCase<List<QuizCard>, Param> {
  final QuizRepository repository;

  FetchQuizCards(this.repository);

  @override
  Future<Either<Failure, List<QuizCard>>> call(Param params) async {
    final fetchQuizCards = params.fetchOnlyToday
        ? await repository.getQuizCardsForTodaysWords()
        : await repository.getQuizCards(params.limit);
    return fetchQuizCards;
  }
}

class Param extends Equatable {
  final int limit;
  final bool fetchOnlyToday;

  const Param({
    @required this.limit,
    this.fetchOnlyToday = false,
  });

  @override
  List<Object> get props => [limit];
}
