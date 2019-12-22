import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/variant_form_model.dart';

import 'pronunciation_model.dart';
import 'entry_model.dart';

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

/// [RelatedEntryModel] class
/// [domainList] (List[BaseInfoModel], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [id] (string): he identifier of the word ,
/// [language] (string, optional): IANA language code specifying the language of the word ,
/// [regionList] (List[BaseInfoModel], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfoModel], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class RelatedEntryModel extends Equatable {
  final List<BaseInfoModel> domainList;
  final String id, language, text;
  final List<BaseInfoModel> regionList;
  final List<BaseInfoModel> registerList;

  RelatedEntryModel({
    this.domainList,
    this.id,
    this.language,
    this.text,
    this.regionList,
    this.registerList,
  });

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
