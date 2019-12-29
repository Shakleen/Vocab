import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class WordCardDetails extends Equatable {
  final String definition;
  final String partOfSpeech;
  final List<String> synonymList;
  final List<String> exampleList;
  final List<String> antonymList;

  const WordCardDetails({
    @required this.definition,
    @required this.partOfSpeech,
    @required this.exampleList,
    @required this.synonymList,
    this.antonymList,
  });

  @override
  List<Object> get props => [
        definition,
        partOfSpeech,
        exampleList,
        synonymList,
        antonymList,
      ];
}
