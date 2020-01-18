import 'package:equatable/equatable.dart';

abstract class WordListBlocEvent extends Equatable {
  const WordListBlocEvent();
}

class GetWordListEvent extends WordListBlocEvent {
  final int limit;

  GetWordListEvent({this.limit = 25});
  
  @override
  List<Object> get props => [limit];
}
