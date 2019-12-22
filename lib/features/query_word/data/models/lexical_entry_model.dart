import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/variant_form_model.dart';

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
class LexicalEntryModel extends Equatable {
  final List<RelatedEntryModel> derivativeOfList, derivativeList;
  final List<EntryModel> entryList;
  final List<BaseInfoModel> grammaticalFeatureList;
  final String language, text;
  final BaseInfoModel lexicalCategory;
  final List<BaseInfoModel> noteList;
  final List<PronunciationModel> pronunciationList;
  final List<VariantFormModel> variantFormList;

  LexicalEntryModel({
    this.derivativeOfList,
    this.derivativeList,
    this.entryList,
    this.grammaticalFeatureList,
    this.language,
    this.text,
    this.lexicalCategory,
    this.noteList,
    this.pronunciationList,
    this.variantFormList,
  });

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
