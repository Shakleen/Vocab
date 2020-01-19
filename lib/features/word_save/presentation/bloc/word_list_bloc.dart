import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocab/core/error/error_messages.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/word_save/domain/entity/word_details_summary.dart';
import 'package:vocab/features/word_save/domain/usecase/get_saved_words.dart';
import './bloc.dart';

class WordListBloc extends Bloc<WordListBlocEvent, WordListBlocState> {
  final GetSavedWords _usecase;
  final List<WordDetailsSummary> _wordList = [];
  int _offset = 0;

  WordListBloc(this._usecase);

  bool get hasReachedEnd => _usecase.endReached;

  @override
  WordListBlocState get initialState => InitialWordListBlocState();

  @override
  Stream<WordListBlocState> mapEventToState(
    WordListBlocEvent event,
  ) async* {
    if (event is GetWordListEvent) {
      final result = await _usecase(Param(
        limit: event.limit,
        offset: _offset,
      ));
      _offset += event.limit;

      yield* result.fold(_handleFailure, _handleSuccess);
    }
  }

  Stream<WordListBlocState> _handleFailure(Failure l) async* {
    yield ErrorWordListBlocState(getErrorMessage(l));
  }

  Stream<WordListBlocState> _handleSuccess(List<WordDetailsSummary> r) async* {
    if (_usecase.endReached == false) {
      _wordList.addAll(r);
    }
    yield LoadedWordListBlocState(_wordList);
  }
}
