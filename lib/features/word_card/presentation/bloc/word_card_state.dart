import 'package:equatable/equatable.dart';
import 'package:vocab/core/entities/word_card.dart';

abstract class WordCardState extends Equatable {
  const WordCardState();
}

class EmptyState extends WordCardState {
  @override
  List<Object> get props => [];
}

class LoadingState extends WordCardState {
  @override
  List<Object> get props => [];
}

class LoadedState extends WordCardState {
  final WordCard wordCard;

  LoadedState({this.wordCard});

  @override
  List<Object> get props => [wordCard];
}

class ErrorState extends WordCardState {
  final String message;

  ErrorState({this.message});
  
  @override
  List<Object> get props => [message];
}
