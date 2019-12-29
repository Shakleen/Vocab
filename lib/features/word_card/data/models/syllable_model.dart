import 'package:vocab/features/word_card/domain/entities/syllable.dart';

import 'object_converter.dart';

class SyllableModel extends Syllable {
  SyllableModel({int count, List<String> list})
      : super(count: count, list: list);

  factory SyllableModel.fromJson(Map<String, dynamic> json) {
    return SyllableModel(
      count: json[Syllable.getKey(SyllableKeyNames.count)],
      list: ObjectConverter.toStringList(
        json[Syllable.getKey(SyllableKeyNames.list)],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    json[Syllable.getKey(SyllableKeyNames.count)] = this.count;
    json[Syllable.getKey(SyllableKeyNames.list)] = this.list;

    return json;
  }
}
