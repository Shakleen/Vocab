import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocab/core/error/error_messages.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/util/input_converter.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/features/word_card/domain/usecase/get_word_card.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class WordCardBloc extends Bloc<WordCardEvent, WordCardState> {
  final GetWordCard getWordCard;
  final InputConverter converter;

  WordCardBloc({
    @required this.getWordCard,
    @required this.converter,
  });

  @override
  WordCardState get initialState => EmptyState();

  @override
  Stream<WordCardState> mapEventToState(
    WordCardEvent event,
  ) async* {
    if (event is GetWordCardEvent) {
      final result = converter.convertToLower(event.queryWord);
      yield* result.fold(_handleInvalidInput, _handleValidInput);
    }
  }

  Stream<WordCardState> _handleInvalidInput(InvalidInputFailure l) async* {
    yield ErrorState(message: INVALID_INPUT_ERROR_MESSAGE);
  }

  Stream<WordCardState> _handleValidInput(String r) async* {
    yield LoadingState();
    final result = await getWordCard(Param(queryWord: r));
    yield* result.fold(_handleFailure, _handleSuccess);
  }

  Stream<WordCardState> _handleFailure(Failure l) async* {
    yield ErrorState(message: getErrorMessage(l));
  }

  Stream<WordCardState> _handleSuccess(WordCard r) async* {
    yield LoadedState(wordCard: r);
  }
}
