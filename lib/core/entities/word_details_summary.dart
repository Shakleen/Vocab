import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class WordDetailsSummary extends Equatable {
  final String word;
  final DateTime addedOn;
  final int senses;

  WordDetailsSummary({
    @required this.word,
    @required this.addedOn,
    @required this.senses,
  });

  @override
  List<Object> get props => [word, addedOn, senses];
}
