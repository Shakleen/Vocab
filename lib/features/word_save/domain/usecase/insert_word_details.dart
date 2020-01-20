import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/word_save/domain/repository/word_save_repository.dart';

class InsertWordDetails extends UseCase<bool, Param> {
  final WordSaveRepository repository;

  InsertWordDetails({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(Param params) async {
    final attemptInsertion =
        await repository.insertWordDetails(params.wordCard);
    return attemptInsertion.fold(
      (Failure l) => Left(l),
      (bool r) => Right(r),
    );
  }
}

class Param extends Equatable {
  final WordCard wordCard;

  const Param({@required this.wordCard});

  @override
  List<Object> get props => [wordCard];
}
