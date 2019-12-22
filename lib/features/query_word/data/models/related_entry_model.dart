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

  @override
  List<Object> get props => [
        domainList,
        id,
        language,
        text,
        regionList,
        registerList,
      ];
}
