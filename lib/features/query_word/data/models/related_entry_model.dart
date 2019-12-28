import 'package:vocab/features/query_word/domain/entities/related_entry.dart';

import 'base_info_model.dart';

/// [RelatedEntryModel] class
/// [domainList] (List[BaseInfoModel], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [id] (string): he identifier of the word ,
/// [language] (string, optional): IANA language code specifying the language of the word ,
/// [regionList] (List[BaseInfoModel], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfoModel], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class RelatedEntryModel extends RelatedEntry {
  RelatedEntryModel({
    List<BaseInfoModel> domainList,
    String id,
    String language,
    String text,
    List<BaseInfoModel> regionList,
    List<BaseInfoModel> registerList,
  }) : super(
          domainList: domainList,
          id: id,
          language: language,
          text: text,
          regionList: regionList,
          registerList: registerList,
        );

  factory RelatedEntryModel.fromJson(Map<String, dynamic> json) {
    final Function baseInfoModelToJson =
        (element) => BaseInfoModel.fromJson(element);
    final Function toBaseinfoList = (key) => List<BaseInfoModel>.from(
          json[key]?.map(baseInfoModelToJson),
        );
    return RelatedEntryModel(
      id: json['id'],
      language: json['language'],
      text: json['text'],
      domainList: toBaseinfoList('domains'),
      regionList: toBaseinfoList('regions'),
      registerList: toBaseinfoList('registers'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    final Function baseInfoToString = (baseInfo) => baseInfo.toJson();

    json['id'] = this.id;
    json['language'] = this.language;
    json['text'] = this.text;
    json['domains'] = this.domainList?.map(baseInfoToString);
    json['regions'] = this.regionList?.map(baseInfoToString);
    json['registers'] = this.registerList?.map(baseInfoToString);

    return json;
  }
}
