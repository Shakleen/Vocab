import 'package:vocab/features/query_word/domain/entities/lexical_entry.dart';

import 'base_info_model.dart';
import 'variant_form_model.dart';
import 'pronunciation_model.dart';
import 'entry_model.dart';
import 'related_entry_model.dart';

/// [LexicalEntryModel] class
///
/// Properties:
/// [derivativeOfList] (List[RelatedEntryModel], optional): Other words from which this one derives ,
/// [derivativeList] (List[RelatedEntryModel], optional): Other words from which their Sense derives ,
/// [entryList] (List[EntryModel], optional),
/// [grammaticalFeatureList] (List[BaseInfoModel], optional),
/// [language] (string): IANA language code ,
/// [lexicalCategory] ([BaseInfoModel]): A linguistic category of words (or more precisely lexical items),
/// generally defined by the syntactic or morphological behaviour of the lexical item in question, such as
/// noun or verb ,
/// [noteList] ([BaseInfoModel], optional),
/// [pronunciationList] (List[PronunciationModel], optional),
/// [text] (string): A given written or spoken realisation of an entry. ,
/// [variantFormList] (List[VariantFormModel], optional): Various words that are used interchangeably depending
/// on the context, e.g 'a' and 'an'
class LexicalEntryModel extends LexicalEntry {
  LexicalEntryModel({
    List<RelatedEntryModel> derivativeOfList,
    List<RelatedEntryModel> derivativeList,
    List<EntryModel> entryList,
    List<BaseInfoModel> grammaticalFeatureList,
    String language,
    String text,
    BaseInfoModel lexicalCategory,
    List<BaseInfoModel> noteList,
    List<PronunciationModel> pronunciationList,
    List<VariantFormModel> variantFormList,
  }) : super(
          derivativeOfList: derivativeOfList,
          derivativeList: derivativeList,
          entryList: entryList,
          grammaticalFeatureList: grammaticalFeatureList,
          language: language,
          text: text,
          lexicalCategory: lexicalCategory,
          noteList: noteList,
          pronunciationList: pronunciationList,
          variantFormList: variantFormList,
        );

  factory LexicalEntryModel.fromJson(Map<String, dynamic> json) {
    final Function toBaseinfoList = (key) => List<BaseInfoModel>.from(
          json[key].map((element) => BaseInfoModel.fromJson(element)),
        );
    final Function toEntryList = (key) => List<EntryModel>.from(
          json[key].map((element) => EntryModel.fromJson(element)),
        );
    final Function toRelatedEntryList = (key) => List<RelatedEntryModel>.from(
          json[key].map((element) => RelatedEntryModel.fromJson(element)),
        );
    final Function toPronunciationList = (key) => List<PronunciationModel>.from(
          json[key].map((element) => PronunciationModel.fromJson(element)),
        );
    final Function toVariantFormList = (key) => List<VariantFormModel>.from(
          json[key].map((element) => VariantFormModel.fromJson(element)),
        );
    return LexicalEntryModel(
      derivativeList: toRelatedEntryList('derivatives'),
      derivativeOfList: toRelatedEntryList('derivativeOf'),
      entryList: toEntryList('entries'),
      language: json['language'],
      text: json['text'],
      lexicalCategory: BaseInfoModel.fromJson(json['lexicalCategory']),
      grammaticalFeatureList: toBaseinfoList('grammaticalFeatures'),
      noteList: toBaseinfoList('notes'),
      pronunciationList: toPronunciationList('pronunciations'),
      variantFormList: toVariantFormList('variantForms'),
    );
  }

  Map<String, dynamic> toJson() {
    final Function toString = (element) => element.toJson();
    final Map<String, dynamic> json = {};

    json['derivatives'] = this.derivativeList.map(toString);
    json['derivativeOf'] = this.derivativeOfList.map(toString);
    json['entries'] = this.entryList.map(toString);
    json['language'] = this.language;
    json['text'] = this.text;
    json['lexicalCategory'] = toString(this.lexicalCategory);
    json['grammaticalFeatures'] = this.grammaticalFeatureList.map(toString);
    json['notes'] = this.noteList.map(toString);
    json['pronunciations'] = this.pronunciationList.map(toString);
    json['variantForms'] = this.variantFormList.map(toString);

    return json;
  }
}
