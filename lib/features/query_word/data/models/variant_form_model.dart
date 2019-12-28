import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/domain/entities/variant_form.dart';

import 'pronunciation_model.dart';

/// [VariantFormModel] class
/// [domainList] (List[BaseInfoModel], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[BaseInfoModel], optional),
/// [pronunciationList] (List[PronunciationModel], optional): A grouping of pronunciation information ,
/// [regionList] (List[BaseInfoModel], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfoModel], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class VariantFormModel extends VariantForm {
  VariantFormModel({
    List<BaseInfoModel> domainList,
    String text,
    List<BaseInfoModel> regionList,
    List<BaseInfoModel> registerList,
    List<BaseInfoModel> noteList,
    List<PronunciationModel> pronunciationList,
  }) : super(
          noteList: noteList,
          domainList: domainList,
          text: text,
          regionList: regionList,
          registerList: registerList,
          pronunciationList: pronunciationList,
        );

  factory VariantFormModel.fromJson(Map<String, dynamic> json) {
    final Function toBaseinfoList = (key) => List<BaseInfoModel>.from(
          json[key]?.map((element) => BaseInfoModel.fromJson(element)),
        );
    final Function toPronunciationList = (key) => List<PronunciationModel>.from(
          json[key]?.map((element) => PronunciationModel.fromJson(element)),
        );
    return VariantFormModel(
      text: json['text'],
      domainList: toBaseinfoList('domains'),
      noteList: toBaseinfoList('notes'),
      regionList: toBaseinfoList('regions'),
      registerList: toBaseinfoList('registers'),
      pronunciationList: toPronunciationList('pronunciations'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    final Function baseInfoToString = (baseInfo) => baseInfo.toJson();
    final Function pronunciationToString =
        (pronunciation) => pronunciation.toJson();

    json['text'] = this.text;
    json['domains'] = this.domainList?.map(baseInfoToString);
    json['regions'] = this.regionList?.map(baseInfoToString);
    json['registers'] = this.registerList?.map(baseInfoToString);
    json['notes'] = this.noteList?.map(baseInfoToString);
    json['pronunciations'] = this.pronunciationList?.map(pronunciationToString);

    return json;
  }
}
