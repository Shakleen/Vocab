import 'package:equatable/equatable.dart';
import 'package:vocab/core/enums/part_of_speech.dart';

class WordCardDetails extends Equatable {
  final int id;
  final String definition;
  final PartOfSpeechType partOfSpeech;
  final List<String> synonymList;
  final List<String> exampleList;
  final List<String> antonymList;

  WordCardDetails({
    this.id,
    this.definition,
    this.partOfSpeech,
    this.synonymList,
    this.exampleList,
    this.antonymList,
  });

  @override
  List<Object> get props => [
        id,
        definition,
        partOfSpeech,
        exampleList,
        synonymList,
        antonymList,
      ];
}
