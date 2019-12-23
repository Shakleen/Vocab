import 'package:vocab/features/query_word/domain/entities/example.dart';

import 'base_info_model.dart';

/// [ExampleModel] class
/// [definitionList] (List[strings], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (List[BaseInfoModel], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[CategorizedText], optional),
/// [regionList] (List[BaseInfoModel], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfoModel], optional): A level of language usage, typically with respect to formality. e.g.
/// 'offensive', 'informal' ,
/// [senseIdList] (List[strings], optional): The list of sense identifiers related to the example. Provided in the
/// sentences endpoint only. ,
/// [text] (string)
class ExampleModel extends Example {
  ExampleModel({
    List<String> definitionList,
    List<BaseInfoModel> domainList,
    List<BaseInfoModel> noteList,
    List<BaseInfoModel> regionList,
    List<BaseInfoModel> registerList,
    List<String> senseIdList,
    String text,
  }) : super(
          definitionList: definitionList,
          domainList: domainList,
          noteList: noteList,
          regionList: regionList,
          registerList: registerList,
          senseIdList: senseIdList,
          text: text,
        );

  factory ExampleModel.fromJson(Map<String, dynamic> json) {
    final Function baseInfoModelToJson =
        (element) => BaseInfoModel.fromJson(element);
    final Function toBaseinfoList = (key) => List<BaseInfoModel>.from(
          json[key].map(baseInfoModelToJson),
        );
    return ExampleModel(
      text: json['text'],
      domainList: toBaseinfoList('domains'),
      noteList: toBaseinfoList('notes'),
      regionList: toBaseinfoList('regions'),
      registerList: toBaseinfoList('registers'),
      definitionList: List<String>.from(json['definitions']),
      senseIdList: List<String>.from(json['senseIds']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    final Function baseInfoToString = (baseInfo) => baseInfo.toJson();

    json['text'] = this.text;
    json['domains'] = this.domainList.map(baseInfoToString);
    json['regions'] = this.regionList.map(baseInfoToString);
    json['registers'] = this.registerList.map(baseInfoToString);
    json['notes'] = this.noteList.map(baseInfoToString);
    json['definitions'] = this.definitionList;
    json['senseIds'] = this.senseIdList;

    return json;
  }
}
