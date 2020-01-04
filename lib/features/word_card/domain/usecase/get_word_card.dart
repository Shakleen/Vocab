import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:vocab/features/word_card/domain/entities/word_details.dart';
import 'package:vocab/features/word_card/domain/entities/word_search_result.dart';
import 'package:vocab/features/word_card/domain/repository/word_card_repository.dart';

class GetWordCard extends UseCase<WordCard, Param> {
  final WordCardRepository repository;

  GetWordCard({@required this.repository});

  @override
  Future<Either<Failure, WordCard>> call(Param params) async {
    final result = await repository.getWordInformation(params.queryWord);
    return result.fold(_handleFailure, _handleSuccess);
  }

  FutureOr<Either<Failure, WordCard>> _handleFailure(Failure l) {
    return Left(l);
  }

  FutureOr<Either<Failure, WordCard>> _handleSuccess(WordSearchResult r) {
    return Right(
      WordCard(
        word: r.word,
        syllables: r.syllables,
        pronunciation: r.pronunciation,
        detailList: r.results.map(_toWordCardDetails).toList(),
      ),
    );
  }

  WordCardDetails _toWordCardDetails(WordDetails e) => WordCardDetails(
        definition: e.definition,
        synonymList: e.synonymList,
        antonymList: e.antonymList,
        exampleList: e.exampleList,
        partOfSpeech: e.partOfSpeech,
      );
}

class Param extends Equatable {
  final String queryWord;

  const Param({@required this.queryWord});

  @override
  List<Object> get props => [queryWord];
}
