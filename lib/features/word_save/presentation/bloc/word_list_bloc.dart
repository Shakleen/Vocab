import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocab/core/error/error_messages.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/word_save/domain/entity/word_details_summary.dart';
import 'package:vocab/features/word_save/domain/usecase/get_saved_words.dart';
import './bloc.dart';

class WordListBloc extends Bloc<WordListBlocEvent, WordListBlocState> {
  final GetSavedWords usecase;
  final List<WordDetailsSummary> _wordList = [];
  int _offset = 0;

  WordListBloc(this.usecase);

  @override
  WordListBlocState get initialState => InitialWordListBlocState();

  @override
  Stream<WordListBlocState> mapEventToState(
    WordListBlocEvent event,
  ) async* {
    if (event is GetWordListEvent) {
      yield LoadingWordListBlocState();

      final result = await usecase(
        Param(limit: event.limit, offset: _offset),
      );

      yield* result.fold(_handleFailure, _handleSuccess);
    }
  }

  Stream<WordListBlocState> _handleFailure(Failure l) async* {
    yield ErrorWordListBlocState(getErrorMessage(l));
  }

  Stream<WordListBlocState> _handleSuccess(List<WordDetailsSummary> r) async* {
    if (usecase.endReached == false) {
      _wordList.addAll(r);
      _offset += r.length;
    }
    yield LoadedWordListBlocState(_wordList);
  }
}
