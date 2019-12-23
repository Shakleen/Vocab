import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/domain/entities/pronunciation.dart';

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

  factory PronunciationModel.fromJson(Map<String, dynamic> jsonData) {
    final Function baseInfoModelToJson =
        (element) => BaseInfoModel.fromJson(element);
    final Function toBaseinfoList = (key) => List<BaseInfoModel>.from(
          jsonData[key].map(baseInfoModelToJson),
        );

    return PronunciationModel(
      audioFileUrl: jsonData['audioFile'],
      dialectList: List<String>.from(jsonData['dialects']),
      phoneticNotation: jsonData['phoneticNotation'],
      phoneticSpelling: jsonData['phoneticSpelling'],
      regionList: toBaseinfoList('regions'),
      registerList: toBaseinfoList('registers'),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};
    final Function baseInfoToString = (baseInfo) => baseInfo.toJson();

    jsonData['audioFile'] = this.audioFileUrl;
    jsonData['dialects'] = this.dialectList;
    jsonData['phoneticNotation'] = this.phoneticNotation;
    jsonData['phoneticSpelling'] = this.phoneticSpelling;
    jsonData['regions'] = this.regionList.map(baseInfoToString);
    jsonData['registers'] = this.registerList.map(baseInfoToString);

    return jsonData;
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
