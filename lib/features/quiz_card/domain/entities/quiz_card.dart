import 'package:equatable/equatable.dart';

class QuizCard extends Equatable {
  final String front;
  final String back;
  final DateTime dueDate;
  final bool isImportant;
  final int level;
  final int id;
  final int frontType, backType;
  final String word;

  QuizCard({
    this.word,
    this.frontType,
    this.backType,
    this.front,
    this.back,
    this.dueDate,
    this.isImportant,
    this.level,
    this.id,
  });

  @override
  List<Object> get props => [
        word,
        frontType,
        backType,
        front,
        back,
        dueDate,
        isImportant,
        level,
        id,
      ];
}
