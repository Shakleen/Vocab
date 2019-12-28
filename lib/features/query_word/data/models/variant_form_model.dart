import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/domain/entities/variant_form.dart';

import 'object_converter.dart';
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
    return VariantFormModel(
      text: json['text'],
      domainList: ObjectConverter.toBaseinfoList(json['domains']),
      noteList: ObjectConverter.toBaseinfoList(json['notes']),
      regionList: ObjectConverter.toBaseinfoList(json['regions']),
      registerList: ObjectConverter.toBaseinfoList(json['registers']),
      pronunciationList: ObjectConverter.toPronunciationList(json['pronunciations']),
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
