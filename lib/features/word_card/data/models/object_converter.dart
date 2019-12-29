import 'package:vocab/features/word_card/data/models/word_details_model.dart';

class ObjectConverter {
  static List<T> _toList<T>(data, converter) => List.from(data.map(converter));

  static List<WordDetailsModel> toWordDetailsList(data) {
    return data != null
        ? _toList<WordDetailsModel>(data, (e) => WordDetailsModel.fromJson(e))
        : [];
  }

  static List<String> toStringList(data) {
    return data != null ? List<String>.from(data) : null;
  }
}
