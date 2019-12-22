import 'package:vocab/features/query_word/domain/entities/lexical_entry.dart';

import 'base_info_model.dart';
import 'variant_form_model.dart';
import 'pronunciation_model.dart';
import 'entry_model.dart';
import 'related_entry_model.dart';

/// [LexicalEntryModel] class
///
/// Properties:
/// [derivativeOfList] (List[RelatedEntryModel], optional): Other words from which this one derives ,
/// [derivativeList] (List[RelatedEntryModel], optional): Other words from which their Sense derives ,
/// [entryList] (List[EntryModel], optional),
/// [grammaticalFeatureList] (List[BaseInfoModel], optional),
/// [language] (string): IANA language code ,
/// [lexicalCategory] ([BaseInfoModel]): A linguistic category of words (or more precisely lexical items),
/// generally defined by the syntactic or morphological behaviour of the lexical item in question, such as
/// noun or verb ,
/// [noteList] ([BaseInfoModel], optional),
/// [pronunciationList] (List[PronunciationModel], optional),
/// [text] (string): A given written or spoken realisation of an entry. ,
/// [variantFormList] (List[VariantFormModel], optional): Various words that are used interchangeably depending
/// on the context, e.g 'a' and 'an'
class LexicalEntryModel extends LexicalEntry {
  LexicalEntryModel({
    List<RelatedEntryModel> derivativeOfList,
    List<RelatedEntryModel> derivativeList,
    List<EntryModel> entryList,
    List<BaseInfoModel> grammaticalFeatureList,
    String language,
    String text,
    BaseInfoModel lexicalCategory,
    List<BaseInfoModel> noteList,
    List<PronunciationModel> pronunciationList,
    List<VariantFormModel> variantFormList,
  }) : super(
          derivativeOfList: derivativeOfList,
          derivativeList: derivativeList,
          entryList: entryList,
          grammaticalFeatureList: grammaticalFeatureList,
          language: language,
          text: text,
          lexicalCategory: lexicalCategory,
          noteList: noteList,
          pronunciationList: pronunciationList,
          variantFormList: variantFormList,
        );

  @override
  List<Object> get props => [
        derivativeOfList,
        derivativeList,
        entryList,
        grammaticalFeatureList,
        language,
        text,
        lexicalCategory,
        noteList,
        pronunciationList,
        variantFormList,
      ];
}
