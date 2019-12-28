import 'package:vocab/features/query_word/domain/entities/headword_entry.dart';

import 'pronunciation_model.dart';
import 'lexical_entry_model.dart';

/// [HeadwordEntryModel] class
///
/// Properties:
/// [id] (string): The identifier of a word ,
/// [language] (string): IANA language code ,
/// [lexicalEntryList] (List[LexicalEntryModel]): A grouping of various senses in a specific language,
/// and a lexical category that relates to a word ,
/// [pronunciationList] (List[PronunciationModel], optional),
/// [type] ([HeadwordType], optional): The json object type. Could be 'headword', 'inflection' or 'phrase',
/// [word] (string): (DEPRECATED) A given written or spoken realisation of an entry, lowercased.
class HeadwordEntryModel extends HeadwordEntry {
  HeadwordEntryModel({
    String id,
    String language,
    String word,
    String type,
    List<LexicalEntryModel> lexicalEntryList,
    List<PronunciationModel> pronunciationList,
  }) : super(
          id: id,
          language: language,
          word: word,
          type: _StringToHeadwordType(type),
          lexicalEntryList: lexicalEntryList,
          pronunciationList: pronunciationList,
        );

  static HeadwordType _StringToHeadwordType(String type) {
    switch (type.toLowerCase()) {
      case "headword":
        return HeadwordType.Headword;
      case "inflection":
        return HeadwordType.Inflection;
      case "phrase":
        return HeadwordType.Phrase;
      default:
        throw Exception('Headword type error!');
    }
  }

  static String _HeadwordTypeToString(HeadwordType type) {
    switch (type) {
      case HeadwordType.Headword:
        return "headword";
      case HeadwordType.Inflection:
        return "inflection";
      case HeadwordType.Phrase:
        return "phrase";
      default:
        throw Exception('Headword type error!');
    }
  }

  factory HeadwordEntryModel.fromJson(Map<String, dynamic> json) {
    final Function toPronunciationList = (key) => List<PronunciationModel>.from(
          json[key]?.map((element) => PronunciationModel.fromJson(element)),
        );
    final Function toLexicalList = (key) => List<LexicalEntryModel>.from(
          json[key]?.map((element) => LexicalEntryModel.fromJson(element)),
        );
    return HeadwordEntryModel(
      id: json['id'],
      language: json['language'],
      word: json['word'],
      type: json['type'],
      lexicalEntryList: toLexicalList('lexicalEntries'),
      pronunciationList: toPronunciationList('pronunciations'),
    );
  }

  Map<String, dynamic> toJson() {
    final Function toString = (element) => element.toJson();
    final Map<String, dynamic> json = {};

    json['id'] = this.id;
    json['language'] = this.language;
    json['word'] = this.word;
    json['type'] = _HeadwordTypeToString(this.type);
    json['lexicalEntries'] = this.lexicalEntryList?.map(toString);
    json['pronunciations'] = this.pronunciationList?.map(toString);

    return json;
  }
}
