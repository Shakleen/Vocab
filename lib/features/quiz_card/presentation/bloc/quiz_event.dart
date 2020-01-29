import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();
}

class InitiateQuizEvent implements QuizEvent {
  final int limit;
  final bool fetchOnlyToday;

  InitiateQuizEvent({
    this.limit = 25,
    this.fetchOnlyToday = false,
  });

  @override
  List<Object> get props => [limit];
}

class AnswerCardQuizEvent implements QuizEvent {
  final int level, cardID;

  AnswerCardQuizEvent({
    @required this.cardID,
    this.level = 0,
  });

  @override
  List<Object> get props => [level, cardID];
}

class RevealCardQuizEvent implements QuizEvent {
  @override
  List<Object> get props => [];
}

class UndoAnswerQuizEvent implements QuizEvent {
  @override
  List<Object> get props => [];
}
