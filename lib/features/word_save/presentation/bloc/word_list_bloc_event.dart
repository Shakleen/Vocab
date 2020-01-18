import 'package:equatable/equatable.dart';

abstract class WordListBlocEvent extends Equatable {
  const WordListBlocEvent();
}

class GetWordListEvent extends WordListBlocEvent {
  final int offset, limit;

  GetWordListEvent({this.limit = 25, this.offset = 25});
  
  @override
  List<Object> get props => [offset, limit];
}
