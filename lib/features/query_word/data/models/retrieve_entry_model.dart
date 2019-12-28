import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

import 'headword_entry_model.dart';

class RetrieveEntryModel extends RetrieveEntry {
  RetrieveEntryModel({
    Map<String, String> metaData,
    String id,
    String word,
    List<HeadwordEntryModel> resultList,
  }) : super(
          metaData: metaData,
          id: id,
          word: word,
          resultList: resultList,
        );

  factory RetrieveEntryModel.fromJson(Map<String, dynamic> json) =>
      RetrieveEntryModel(
        id: json['id'],
        word: json['word'],
        metaData: _buildMetaData(json['metadata']),
        resultList: List<HeadwordEntryModel>.from(json['results']?.map(
          (element) => HeadwordEntryModel.fromJson(element),
        )),
      );

  Map<String, dynamic> toJson() {
    final Function toString = (result) => result.toJson();
    final Map<String, dynamic> json = {};
    
    json['metadata'] = this.metaData;
    json['id'] = this.id;
    json['word'] = this.word;
    json['results'] = this.resultList?.map(toString);

    return json;
  }

  static Map<String, String> _buildMetaData(json) {
    final Map<String, String> metaData = {};
    metaData['operation'] = json['operation'];
    metaData['provider'] = json['provider'];
    metaData['schema'] = json['schema'];
    return metaData;
  }
}
