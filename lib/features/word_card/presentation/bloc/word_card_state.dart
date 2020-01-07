import 'package:equatable/equatable.dart';
import 'package:vocab/core/entities/word_card.dart';

abstract class WordCardState extends Equatable {
  const WordCardState();
}

class EmptyWordCardState extends WordCardState {
  @override
  List<Object> get props => [];
}

class LoadingWordCardState extends WordCardState {
  @override
  List<Object> get props => [];
}

class LoadedWordCardState extends WordCardState {
  final WordCard wordCard;

  LoadedWordCardState({this.wordCard});

  @override
  List<Object> get props => [wordCard];
}

class ErrorWordCardState extends WordCardState {
  final String message;

  ErrorWordCardState({this.message});
  
  @override
  List<Object> get props => [message];
}
