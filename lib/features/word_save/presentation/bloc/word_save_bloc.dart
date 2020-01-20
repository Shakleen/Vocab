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
      yield* _handleInsertionEvent(event.wordDetails);
    } else if (event is UpdateWordEvent) {
      yield ProcessingWordSaveState();
      yield* _handleUpdateEvent(event.wordDetails);
    }
  }

  Stream<WordSaveState> _handleInsertionEvent(Map<String, dynamic> wordDetails) async* {
    final attemptInsertion =
        await insertUsecase(insert.Param(wordDetails: wordDetails));
    yield* attemptInsertion.fold(_handleFailure, _handleSuccess);
  }

  Stream<WordSaveState> _handleUpdateEvent(Map<String, dynamic> wordDetails) async* {
    final attemptUpdate =
        await updateUsecase(update.Param(wordDetails: wordDetails));
    yield* attemptUpdate.fold(_handleFailure, _handleSuccess);
  }

  Stream<WordSaveState> _handleFailure(Failure l) async* {
    yield ErrorWordSaveState(getErrorMessage(l));
  }

  Stream<WordSaveState> _handleSuccess(bool r) async* {
    yield FinishedWordSaveState(r);
  }
}
