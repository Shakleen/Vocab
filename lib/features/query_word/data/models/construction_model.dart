import 'package:vocab/features/query_word/domain/entities/construction.dart';

import 'base_info_model.dart';
import 'object_converter.dart';

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
    return ConstructionModel(
      text: json['text'],
      domainList: ObjectConverter.toBaseinfoList(json['domains']),
      noteList: ObjectConverter.toBaseinfoList(json['notes']),
      regionList: ObjectConverter.toBaseinfoList(json['regions']),
      registerList: ObjectConverter.toBaseinfoList(json['registers']),
      exampleList: ObjectConverter.toStringList(json['examples']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    final Function baseInfoToString = (baseInfo) => baseInfo.toJson();

    json['text'] = this.text;
    json['domains'] = this.domainList?.map(baseInfoToString);
    json['regions'] = this.regionList?.map(baseInfoToString);
    json['registers'] = this.registerList?.map(baseInfoToString);
    json['notes'] = this.noteList?.map(baseInfoToString);
    json['examples'] = this.exampleList;

    return json;
  }
}
