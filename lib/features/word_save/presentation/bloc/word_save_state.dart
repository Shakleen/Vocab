import 'package:equatable/equatable.dart';

abstract class WordSaveState extends Equatable {
  const WordSaveState();
}

class InitialWordSaveState extends WordSaveState {
  @override
  List<Object> get props => [];
}

class ProcessingWordSaveState extends WordSaveState {
  @override
  List<Object> get props => [];
}

class FinishedWordSaveState extends WordSaveState {
  final bool result;

  FinishedWordSaveState(this.result);

  @override
  List<Object> get props => [result];
}

class ErrorWordSaveState extends WordSaveState {
  final String message;

  ErrorWordSaveState(this.message);

  @override
  List<Object> get props => [message];
}
