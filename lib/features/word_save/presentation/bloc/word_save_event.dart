import 'package:equatable/equatable.dart';

abstract class WordSaveEvent extends Equatable {
  const WordSaveEvent();
}

class InsertWordEvent extends WordSaveEvent {
  final Map<String, dynamic> wordDetails;

  InsertWordEvent(this.wordDetails);
  
  @override
  List<Object> get props => [wordDetails];
}

class UpdateWordEvent extends WordSaveEvent {
  final Map<String, dynamic> wordDetails;

  UpdateWordEvent(this.wordDetails);
  
  @override
  List<Object> get props => [wordDetails];
}
