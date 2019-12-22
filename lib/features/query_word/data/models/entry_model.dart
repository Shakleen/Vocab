import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/domain/entities/entry.dart';

import 'sense_model.dart';
import 'pronunciation_model.dart';
import 'base_info_model.dart';
import 'variant_form_model.dart';

/// [EntryModel] class
/// [etymologyList] (List[String], optional): The origin of the word and the way in which its meaning has changed throughout history ,
/// [grammaticalFeatureList] (List[BaseInfoModel], optional),
/// [homographNumber] (string, optional): Identifies the homograph grouping. The last two digits identify different entries of the same homograph. The first one/two digits identify the homograph number. ,
/// [noteList] (List[BaseInfoModel], optional),
/// [pronunciationList] (List[PronunciationModel], optional),
/// [senseList] (Array[SenseModel], optional): Complete list of senses ,
/// [variantForms] (List[VariantFormModel], optional): Various words that are used interchangeably depending on the context, e.g 'a' and 'an'
class EntryModel extends Entry {
  EntryModel({
    List<String> etymologyList,
    List<BaseInfoModel> grammaticalFeatureList,
    String homographNumber,
    List<BaseInfoModel> noteList,
    List<PronunciationModel> pronunciationList,
    List<SenseModel> senseList,
    List<VariantFormModel> variantFormList,
  }) : super(
          etymologyList: etymologyList,
          grammaticalFeatureList: grammaticalFeatureList,
          homographNumber: homographNumber,
          noteList: noteList,
          pronunciationList: pronunciationList,
          senseList: senseList,
          variantFormList: variantFormList,
        );

  @override
  List<Object> get props => [
        etymologyList,
        grammaticalFeatureList,
        homographNumber,
        noteList,
        pronunciationList,
        senseList,
        variantFormList,
      ];
}
