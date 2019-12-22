import 'package:equatable/equatable.dart';
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

  @override
  List<Object> get props => [
        noteList,
        domainList,
        text,
        regionList,
        registerList,
        pronunciationList,
      ];
}
