import 'package:vocab/core/entities/pronunciation.dart';

class PronunciationModel extends Pronunciation {
  PronunciationModel({String all}) : super(all: all);

  factory PronunciationModel.fromJson(Map<String, dynamic> json) {
    return PronunciationModel(
      all: json[Pronunciation.getKey(PronunciationKeyNames.all)],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    json[Pronunciation.getKey(PronunciationKeyNames.all)] = this.all;

    return json;
  }
}
