import 'package:equatable/equatable.dart';

abstract class WordCardEvent extends Equatable {
  const WordCardEvent();
}

class GetWordDetailsEvent extends WordCardEvent {
  @override
  List<Object> get props => [];
}
