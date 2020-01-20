import 'package:equatable/equatable.dart';
import 'package:vocab/core/entities/word_card.dart';

abstract class WordSaveEvent extends Equatable {
  const WordSaveEvent();
}

class InsertWordEvent extends WordSaveEvent {
  final WordCard wordCard;

  InsertWordEvent(this.wordCard);
  
  @override
  List<Object> get props => [wordCard];
}

class UpdateWordEvent extends WordSaveEvent {
  final WordCard wordCard;

  UpdateWordEvent(this.wordCard);
  
  @override
  List<Object> get props => [wordCard];
}
