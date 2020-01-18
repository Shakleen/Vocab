import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/core/database/card_database.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:vocab/features/word_save/domain/entity/word_details_summary.dart';
import 'package:vocab/features/word_save/domain/repository/saved_words_repository.dart';

class GetSavedWords extends UseCase<List<WordDetailsSummary>, Param> {
  final SavedWordsRepository repository;
  bool endReached = false;

  GetSavedWords({@required this.repository});

  @override
  Future<Either<Failure, List<WordDetailsSummary>>> call(Param params) async {
    final fetchEntry = await repository.getWordEntries(
      params.limit,
      params.offset,
    );
    return fetchEntry.fold(_handleEntryFetchFailure, _handleEntryFetchSuccess);
  }

  _handleEntryFetchFailure(Failure l) {
    endReached = l is EmptyListFailure;
    return Left(l);
  }

  _handleEntryFetchSuccess(List<Entry> r) async {
    final List<WordDetailsSummary> resultList = [];

    for (final Entry dbEntry in r) {
      Object senseCount = await _getEntrySenseCount(dbEntry);
      Object word = await _getEntryWord(dbEntry);
      resultList.add(
        WordDetailsSummary(
          word: word is String ? word : null,
          addedOn: dbEntry.addedOn,
          senses: senseCount is int ? senseCount : 0,
        ),
      );
    }
  }

  Future<Object> _getEntryWord(Entry dbEntry) async {
    final fetchWord = await repository.getEntryWord(dbEntry.wordId);
    final word = fetchWord.fold((Failure l) => l, (String r) => r);
    return word;
  }

  Future<Object> _getEntrySenseCount(Entry dbEntry) async {
    final fetchSenseCount = await repository.getEntrySenseCount(dbEntry.id);
    final senseCount = fetchSenseCount.fold((Failure l) => l, (int r) => r);
    return senseCount;
  }
}

class Param extends Equatable {
  final int limit, offset;

  const Param({@required this.limit, @required this.offset});

  @override
  List<Object> get props => [limit, offset];
}
