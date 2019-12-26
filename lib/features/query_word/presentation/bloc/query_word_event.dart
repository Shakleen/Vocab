import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

abstract class QueryWordEvent extends Equatable {
  const QueryWordEvent();
}

class GetWordEntryEvent extends QueryWordEvent {
  final String queryWord;

  GetWordEntryEvent({@required this.queryWord});

  @override
  List<Object> get props => [queryWord];
}
