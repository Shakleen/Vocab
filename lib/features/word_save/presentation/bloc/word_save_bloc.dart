import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/error/error_messages.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/word_save/domain/usecase/insert_word_details.dart'
    as insert;
import 'package:vocab/features/word_save/domain/usecase/update_word_details.dart'
    as update;
import './bloc.dart';
import 'package:meta/meta.dart';

class WordSaveBloc extends Bloc<WordSaveEvent, WordSaveState> {
  final insert.InsertWordDetails insertUsecase;
  final update.UpdateWordDetails updateUsecase;

  WordSaveBloc({
    @required this.insertUsecase,
    @required this.updateUsecase,
  });

  @override
  WordSaveState get initialState => InitialWordSaveState();

  @override
  Stream<WordSaveState> mapEventToState(
    WordSaveEvent event,
  ) async* {
    if (event is InsertWordEvent) {
      yield ProcessingWordSaveState();
      yield* _handleInsertionEvent(event.wordCard);
    } else if (event is UpdateWordEvent) {
      yield ProcessingWordSaveState();
      yield* _handleUpdateEvent(event.wordCard);
    }
  }

  _handleInsertionEvent(WordCard wordCard) async* {
    final attemptInsertion =
        await insertUsecase(insert.Param(wordCard: wordCard));
    yield* attemptInsertion.fold(_handleInsertFailure, _handleInsertSuccess);
  }

  _handleUpdateEvent(WordCard wordCard) async* {}

  _handleInsertFailure(Failure l) async* {
    yield ErrorWordSaveState(getErrorMessage(l));
  }

  _handleInsertSuccess(bool r) async* {
    yield FinishedWordSaveState(r);
  }
}
