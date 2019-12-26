import 'package:equatable/equatable.dart';

abstract class QueryWordState extends Equatable {
  const QueryWordState();
}

class InitialQueryWordState extends QueryWordState {
  @override
  List<Object> get props => [];
}
