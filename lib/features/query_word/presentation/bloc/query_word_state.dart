import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

abstract class QueryWordState extends Equatable {
  const QueryWordState();
}

class InitialState extends QueryWordState {
  @override
  List<Object> get props => [];
}

class LoadingState extends QueryWordState {
  @override
  List<Object> get props => [];
}

class LoadedState extends QueryWordState {
  final RetrieveEntry retrieveEntry;

  LoadedState({@required this.retrieveEntry});
  @override
  List<Object> get props => [retrieveEntry];
}

class ErrorState extends QueryWordState {
  final String message;

  ErrorState({@required this.message});
  @override
  List<Object> get props => [message];
}
