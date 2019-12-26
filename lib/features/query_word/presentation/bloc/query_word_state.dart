import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

abstract class QueryWordState extends Equatable {
  const QueryWordState();
}

class Empty extends QueryWordState {
  @override
  List<Object> get props => [];
}

class Loading extends QueryWordState {
  @override
  List<Object> get props => [];
}

class Loaded extends QueryWordState {
  final RetrieveEntry retrieveEntry;

  Loaded({@required this.retrieveEntry});
  @override
  List<Object> get props => [retrieveEntry];
}

class Error extends QueryWordState {
  final String message;

  Error({@required this.message});
  @override
  List<Object> get props => [message];
}
