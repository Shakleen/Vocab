import 'package:vocab/features/word_card/data/models/object_converter.dart';
import 'package:vocab/features/word_card/domain/entities/word_details.dart';

class WordDetailsModel extends WordDetails {
  WordDetailsModel({
    final String definition,
    final String partOfSpeech,
    final List<String> synonymList,
    final List<String> similarToList,
    final List<String> derivationList,
    final List<String> exampleList,
    final List<String> alsoList,
    final List<String> attributeList,
    final List<String> antonymList,
    final List<String> typeOfList,
    final List<String> inCategoryList,
    final List<String> hasTypeList,
  }) : super(
          definition: definition,
          partOfSpeech: partOfSpeech,
          synonymList: synonymList,
          similarToList: similarToList,
          derivationList: derivationList,
          exampleList: exampleList,
          alsoList: alsoList,
          attributeList: attributeList,
          antonymList: antonymList,
          typeOfList: typeOfList,
          inCategoryList: inCategoryList,
          hasTypeList: hasTypeList,
        );

  factory WordDetailsModel.fromJson(Map<String, dynamic> json) {
    final Function toList = ObjectConverter.toStringList;
    final Function getKey = WordDetails.getKey;
    return WordDetailsModel(
      definition: json[getKey(WordDetailsKeyNames.definition)],
      partOfSpeech: json[getKey(WordDetailsKeyNames.partOfSpeech)],
      synonymList: toList(json[getKey(WordDetailsKeyNames.synonyms)]),
      similarToList: toList(json[getKey(WordDetailsKeyNames.similarTo)]),
      derivationList: toList(json[getKey(WordDetailsKeyNames.derivation)]),
      exampleList: toList(json[getKey(WordDetailsKeyNames.examples)]),
      alsoList: toList(json[getKey(WordDetailsKeyNames.also)]),
      attributeList: toList(json[getKey(WordDetailsKeyNames.attribute)]),
      antonymList: toList(json[getKey(WordDetailsKeyNames.antonyms)]),
      typeOfList: toList(json[getKey(WordDetailsKeyNames.typeOf)]),
      inCategoryList: toList(json[getKey(WordDetailsKeyNames.inCategory)]),
      hasTypeList: toList(json[getKey(WordDetailsKeyNames.hasTypes)]),
    );
  }

  Map<String, dynamic> toJson() {
    final Function getKey = WordDetails.getKey;
    final Map<String, dynamic> json = {};

    json[getKey(WordDetailsKeyNames.definition)] = this.definition;
    json[getKey(WordDetailsKeyNames.partOfSpeech)] = this.partOfSpeech;
    
    if (this.synonymList != null)
      json[getKey(WordDetailsKeyNames.synonyms)] = this.synonymList;
    if (this.similarToList != null)
      json[getKey(WordDetailsKeyNames.similarTo)] = this.similarToList;
    if (this.derivationList != null)
      json[getKey(WordDetailsKeyNames.derivation)] = this.derivationList;
    if (this.exampleList != null)
      json[getKey(WordDetailsKeyNames.examples)] = this.exampleList;
    if (this.alsoList != null)
      json[getKey(WordDetailsKeyNames.also)] = this.alsoList;
    if (this.attributeList != null)
      json[getKey(WordDetailsKeyNames.attribute)] = this.attributeList;
    if (this.antonymList != null)
      json[getKey(WordDetailsKeyNames.antonyms)] = this.antonymList;
    if (this.typeOfList != null)
      json[getKey(WordDetailsKeyNames.typeOf)] = this.typeOfList;
    if (this.inCategoryList != null)
      json[getKey(WordDetailsKeyNames.inCategory)] = this.inCategoryList;
    if (this.hasTypeList != null)
      json[getKey(WordDetailsKeyNames.hasTypes)] = this.hasTypeList;

    return json;
  }
}
