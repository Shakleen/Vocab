import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class WordCardEvent extends Equatable {
  const WordCardEvent();
}

class GetWordCardEvent extends WordCardEvent {
  final String queryWord;

  GetWordCardEvent({@required this.queryWord});
  
  @override
  List<Object> get props => [];
}
