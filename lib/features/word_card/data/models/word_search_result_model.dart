import 'package:vocab/features/word_card/data/models/object_converter.dart';
import 'package:vocab/features/word_card/data/models/pronunciation_model.dart';
import 'package:vocab/features/word_card/data/models/syllable_model.dart';
import 'package:vocab/features/word_card/data/models/word_details_model.dart';
import 'package:vocab/features/word_card/domain/entities/word_search_result.dart';

class WordSearchResultModel extends WordSearchResult {
  WordSearchResultModel({
    String word,
    List<WordDetailsModel> results,
    SyllableModel syllables,
    PronunciationModel pronunciation,
    double frequency,
  }) : super(
          word: word,
          results: results,
          syllables: syllables,
          pronunciation: pronunciation,
          frequency: frequency,
        );

  factory WordSearchResultModel.fromJson(Map<String, dynamic> json) {
    final Function getKey = WordSearchResult.getKey;
    return WordSearchResultModel(
      word: json[getKey(WordSearchResultKeyNames.word)],
      results: ObjectConverter.toWordDetailsList(
        json[getKey(WordSearchResultKeyNames.results)],
      ),
      syllables: SyllableModel.fromJson(
        json[getKey(WordSearchResultKeyNames.syllables)],
      ),
      pronunciation: PronunciationModel.fromJson(
        json[getKey(WordSearchResultKeyNames.pronunciation)],
      ),
      frequency: json[getKey(WordSearchResultKeyNames.frequency)],
    );
  }

  Map<String, dynamic> toJson() {
    final Function getKey = WordSearchResult.getKey;
    final Function toJson = (obj) => obj.toJson();
    final Map<String, dynamic> json = {};

    json[getKey(WordSearchResultKeyNames.word)] = this.word;
    json[getKey(WordSearchResultKeyNames.results)] = this.results.map(toJson);
    json[getKey(WordSearchResultKeyNames.syllables)] = toJson(this.syllables);
    json[getKey(WordSearchResultKeyNames.pronunciation)] = toJson(this.pronunciation);
    json[getKey(WordSearchResultKeyNames.frequency)] = this.frequency;

    return json;
  }
}
