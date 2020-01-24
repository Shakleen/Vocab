import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/enums/part_of_speech.dart';

class WordCardDetailsModel extends WordCardDetails {
  WordCardDetailsModel({
    int id,
    String definition,
    PartOfSpeechType partOfSpeech,
    List<String> synonymList,
    List<String> exampleList,
    List<String> antonymList,
  }) : super(
          id: id,
          definition: definition,
          partOfSpeech: partOfSpeech,
          exampleList: exampleList,
          synonymList: synonymList,
          antonymList: antonymList,
        );

  factory WordCardDetailsModel.fromJson(Map<String, dynamic> json) {
    return WordCardDetailsModel(
      id: json['id'],
      definition: json['definition'],
      partOfSpeech: ID_TO_PART_OF_SPEECH_TYPE[json['partOfSpeech']],
      exampleList: _buildList(json['examples']),
      synonymList: _buildList(json['synonyms']),
      antonymList: _buildList(json['antonyms']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    json['id'] = this.id;
    json['definition'] = this.definition;
    json['examples'] = this.exampleList;
    json['synonyms'] = this.synonymList;
    json['antonyms'] = this.antonymList;
    json['partOfSpeech'] = PART_OF_SPEECH_TYPE_TO_ID[this.partOfSpeech];

    return json;
  }

  static List<String> _buildList(data) {
    if (data != null) {
      return data.map((val) => val.toString()).toList();
    }
  }
}
