import 'package:equatable/equatable.dart';

class WordCardDetails extends Equatable {
  final String definition;
  final String partOfSpeech;
  final List<String> synonymList;
  final List<String> exampleList;
  final List<String> antonymList;

  WordCardDetails({
    this.definition,
    this.partOfSpeech,
    this.synonymList,
    this.exampleList,
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
