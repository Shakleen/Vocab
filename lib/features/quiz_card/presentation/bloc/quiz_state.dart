import 'package:equatable/equatable.dart';
import 'package:vocab/features/quiz_card/domain/entities/quiz_card.dart';

abstract class QuizState extends Equatable {
  const QuizState();
}

class InitQuizState extends QuizState {
  @override
  List<Object> get props => [];
}

class LoadingQuizState extends QuizState {
  @override
  List<Object> get props => [];
}

class NoDueCardsQuizState extends QuizState {
  @override
  List<Object> get props => [];
}

class FinishedQuizState extends QuizState {
  @override
  List<Object> get props => [];
}

class ErrorQuizState extends QuizState {
  final String message;

  ErrorQuizState(this.message);

  @override
  List<Object> get props => [message];
}

class ShowCardFrontState extends QuizState {
  final QuizCard quizCard;

  ShowCardFrontState(this.quizCard);

  @override
  List<Object> get props => [quizCard];
}

class ShowFullCardState extends QuizState {
  final QuizCard quizCard;

  ShowFullCardState(this.quizCard);

  @override
  List<Object> get props => [quizCard];
}