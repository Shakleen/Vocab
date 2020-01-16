import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

abstract class QueryWordState extends Equatable {
  const QueryWordState();
}

class EmptyQueryWordState extends QueryWordState {
  @override
  List<Object> get props => [];
}

class LoadingQueryWordState extends QueryWordState {
  @override
  List<Object> get props => [];
}

class LoadedQueryWordState extends QueryWordState {
  final RetrieveEntry retrieveEntry;

  LoadedQueryWordState({@required this.retrieveEntry});
  @override
  List<Object> get props => [retrieveEntry];
}

class ErrorQueryWordState extends QueryWordState {
  final String message;

  ErrorQueryWordState({@required this.message});
  @override
  List<Object> get props => [message];
}
