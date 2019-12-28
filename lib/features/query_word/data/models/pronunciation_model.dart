import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/domain/entities/pronunciation.dart';

import 'object_converter.dart';

/// [PronunciationModel] class
/// [audioFileUrl] (string, optional): The URL of the sound file ,
/// [dialectList] (List[string], optional): A local or regional variation where the pronunciation occurs,
/// e.g. 'British English' ,
/// [phoneticNotation] (string, optional): The alphabetic system used to display the phonetic spelling ,
/// [phoneticSpelling] (string, optional): Phonetic spelling is the representation of vocal sounds which
/// express pronunciations of words. It is a system of spelling in which each letter represents invariably
/// the same spoken sound ,
/// [regionList] (List[BaseInfoModel], optional): A particular area in which the pronunciation occurs, e.g.
/// 'Great Britain' ,
/// [registerList] (List[BaseInfoModel], optional): A level of language usage, typically with respect to
/// formality. e.g. 'offensive', 'informal'
class PronunciationModel extends Pronunciation {
  PronunciationModel({
    String audioFileUrl,
    String phoneticNotation,
    String phoneticSpelling,
    List<String> dialectList,
    List<BaseInfoModel> regionList,
    List<BaseInfoModel> registerList,
  }) : super(
          audioFileUrl: audioFileUrl,
          phoneticNotation: phoneticNotation,
          phoneticSpelling: phoneticSpelling,
          dialectList: dialectList,
          regionList: regionList,
          registerList: registerList,
        );

  factory PronunciationModel.fromJson(Map<String, dynamic> json) {
    return PronunciationModel(
      audioFileUrl: json['audioFile'],
      dialectList: ObjectConverter.toStringList(json['dialects']),
      phoneticNotation: json['phoneticNotation'],
      phoneticSpelling: json['phoneticSpelling'],
      regionList: ObjectConverter.toBaseinfoList(json['regions']),
      registerList: ObjectConverter.toBaseinfoList(json['registers']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    final Function baseInfoToString = (baseInfo) => baseInfo.toJson();

    json['audioFile'] = this.audioFileUrl;
    json['dialects'] = this.dialectList;
    json['phoneticNotation'] = this.phoneticNotation;
    json['phoneticSpelling'] = this.phoneticSpelling;
    json['regions'] = this.regionList?.map(baseInfoToString);
    json['registers'] = this.registerList?.map(baseInfoToString);

    return json;
  }

  @override
  List<Object> get props => [
        this.audioFileUrl,
        this.phoneticNotation,
        this.phoneticSpelling,
        this.dialectList,
        this.regionList,
        this.registerList,
      ];
}
