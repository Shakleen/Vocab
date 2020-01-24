import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/models/word_card_details_model.dart';

class WordCardModel extends WordCard {
  WordCardModel({
    int id,
    String word,
    String pronunciation,
    List<String> syllables,
    List<WordCardDetailsModel> detailList,
  }) : super(
          id: id,
          word: word,
          pronunciation: pronunciation,
          syllables: syllables,
          detailList: detailList,
        );

  factory WordCardModel.fromJson(Map<String, dynamic> json) {
    return WordCardModel(
      id: json['id'],
      word: json['word'],
      pronunciation: json['pronunciation'],
      syllables: _buildStringList(json['syllables']),
      detailList: _buildDetailList(json['details']),
    );
  }

  Map<String, dynamic> toJson() {
    final Function func = (val) => val.toJson();
    final Map<String, dynamic> json = {};

    json['id'] = this.id;
    json['word'] = this.word;
    json['pronunciation'] = this.pronunciation;
    json['syllables'] = this.syllables;
    json['details'] = this.detailList.map(func);

    return json;
  }

  static List<String> _buildStringList(data) {
    if (data != null) {
      return data.map((val) => val.toString()).toList();
    }
  }

  static List<WordCardDetailsModel> _buildDetailList(data) {
    if (data != null) {
      return data.map((val) => WordCardModel.fromJson(val)).toList();
    }
  }
}
