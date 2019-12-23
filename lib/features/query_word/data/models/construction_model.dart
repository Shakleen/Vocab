import 'package:vocab/features/query_word/domain/entities/construction.dart';

import 'base_info_model.dart';

class ConstructionModel extends Construction {
  ConstructionModel({
    List<BaseInfoModel> domainList,
    List<String> exampleList,
    List<BaseInfoModel> noteList,
    List<BaseInfoModel> regionList,
    List<BaseInfoModel> registerList,
    String text,
  }) : super(
          domainList: domainList,
          exampleList: exampleList,
          noteList: noteList,
          regionList: regionList,
          registerList: registerList,
          text: text,
        );

  factory ConstructionModel.fromJson(Map<String, dynamic> json) {
    final Function baseInfoModelToJson =
        (element) => BaseInfoModel.fromJson(element);
    final Function toBaseinfoList = (key) => List<BaseInfoModel>.from(
          json[key].map(baseInfoModelToJson),
        );
    return ConstructionModel(
      text: json['text'],
      domainList: toBaseinfoList('domains'),
      noteList: toBaseinfoList('notes'),
      regionList: toBaseinfoList('regions'),
      registerList: toBaseinfoList('registers'),
      exampleList: List<String>.from(json['examples']),
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
    json['examples'] = this.exampleList;

    return json;
  }
}
