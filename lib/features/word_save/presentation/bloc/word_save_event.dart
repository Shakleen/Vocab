import 'package:equatable/equatable.dart';
import 'package:vocab/core/entities/word_card.dart';

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
  final WordCard previousWordDetails;
  final Map<String, dynamic> wordDetails;

  UpdateWordEvent(this.wordDetails, this.previousWordDetails);
  
  @override
  List<Object> get props => [wordDetails];
}
