import 'package:equatable/equatable.dart';
import 'package:vocab/features/word_save/domain/entity/word_details_summary.dart';

abstract class WordListBlocState extends Equatable {
  const WordListBlocState();
}

class InitialWordListBlocState extends WordListBlocState {
  @override
  List<Object> get props => [];
}

class LoadingWordListBlocState extends WordListBlocState {
  @override
  List<Object> get props => [];
}

class LoadedWordListBlocState extends WordListBlocState {
  final List<WordDetailsSummary> wordList;

  LoadedWordListBlocState(this.wordList);

  @override
  List<Object> get props => [wordList];
}

class ErrorWordListBlocState extends WordListBlocState {
  final String errorMessage;

  ErrorWordListBlocState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
