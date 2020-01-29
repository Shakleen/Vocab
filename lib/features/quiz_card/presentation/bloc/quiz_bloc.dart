import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocab/core/error/error_messages.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';
import 'package:vocab/features/quiz_card/domain/usecase/fetch_quiz_cards.dart'
    as fetch;
import 'package:vocab/features/quiz_card/domain/usecase/mark_correct.dart'
    as correct;
import 'package:vocab/features/quiz_card/domain/usecase/mark_wrong.dart'
    as wrong;
import './bloc.dart';
import 'package:meta/meta.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final fetch.FetchQuizCards fetchUseCase;
  final correct.MarkCorrect markCorrectUsecase;
  final wrong.MarkWrong markWrongUsecase;
  final List<QuizCard> _quizCards;
  int _index;

  QuizBloc({
    @required this.fetchUseCase,
    @required this.markCorrectUsecase,
    @required this.markWrongUsecase,
  })  : this._quizCards = [],
        this._index = 0;

  int getRemaining() => _quizCards.length - _index;

  @override
  QuizState get initialState {
    _index = 0;
    return InitQuizState();
  }

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event is InitiateQuizEvent) {
      yield LoadingQuizState();

      final fetchQuizCards = await fetchUseCase(
        fetch.Param(limit: event.limit, fetchOnlyToday: event.fetchOnlyToday),
      );
      yield* fetchQuizCards.fold(
        (Failure f) async* {
          if (f is EmptyListFailure) {
            yield NoDueCardsQuizState();
          } else {
            yield ErrorQuizState(getErrorMessage(f));
          }
        },
        (List<QuizCard> r) async* {
          if (_quizCards.isNotEmpty) _quizCards.addAll(r);
          yield ShowCardFrontState(_quizCards[_index]);
        },
      );
    } else if (event is RevealCardQuizEvent) {
      yield ShowFullCardState(_quizCards[_index]);
    } else if (event is AnswerCardQuizEvent) {
      yield LoadingQuizState();
      await _handleAnswerMarking(event);
      yield* _fetchNextCard();
    } else if (event is UndoAnswerQuizEvent) {
      if (_index > 0) {
        yield LoadingQuizState();
        _index -= 1;
        yield ShowCardFrontState(_quizCards[_index]);
      }
    }
  }

  Future _handleAnswerMarking(AnswerCardQuizEvent event) async {
    if (event.level == 0) {
      await markWrongUsecase(wrong.Param(id: event.cardID));
    } else {
      await markCorrectUsecase(
        correct.Param(id: event.cardID, level: event.level),
      );
    }
  }

  Stream<QuizState> _fetchNextCard() async* {
    _index += 1;
    if (_index < _quizCards.length) {
      yield ShowCardFrontState(_quizCards[_index]);
    } else {
      yield FinishedQuizState();
    }
  }
}
