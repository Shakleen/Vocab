import 'package:equatable/equatable.dart';

enum WordDetailsKeyNames {
  definition,
  partOfSpeech,
  synonyms,
  typeOf,
  hasTypes,
  derivation,
  examples,
  inCategory,
  similarTo,
  also,
  attribute,
  antonyms,
}

class WordDetails extends Equatable {
  final String definition;
  final String partOfSpeech;
  final List<String> synonymList;
  final List<String> similarToList;
  final List<String> derivationList;
  final List<String> exampleList;
  final List<String> alsoList;
  final List<String> attributeList;
  final List<String> antonymList;
  final List<String> typeOfList;
  final List<String> inCategoryList;
  final List<String> hasTypeList;

  const WordDetails({
    this.definition,
    this.partOfSpeech,
    this.synonymList,
    this.similarToList,
    this.derivationList,
    this.exampleList,
    this.alsoList,
    this.attributeList,
    this.antonymList,
    this.typeOfList,
    this.inCategoryList,
    this.hasTypeList,
  });

  @override
  List<Object> get props => [
        definition,
        partOfSpeech,
        synonymList,
        similarToList,
        derivationList,
        exampleList,
        alsoList,
        attributeList,
        antonymList,
        typeOfList,
        inCategoryList,
        hasTypeList,
      ];

  static String getKey(WordDetailsKeyNames name) =>
      name.toString().split('.').last;
}
