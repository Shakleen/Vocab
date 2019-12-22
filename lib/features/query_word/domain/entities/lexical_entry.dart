import 'package:equatable/equatable.dart';

import 'base_info.dart';
import 'variant_form.dart';
import 'pronunciation.dart';
import 'entry.dart';
import 'related_entry.dart';

/// [LexicalEntry] class
///
/// Properties:
/// [derivativeOfList] (List[RelatedEntry], optional): Other words from which this one derives ,
/// [derivativeList] (List[RelatedEntry], optional): Other words from which their Sense derives ,
/// [entryList] (List[Entry], optional),
/// [grammaticalFeatureList] (List[BaseInfo], optional),
/// [language] (string): IANA language code ,
/// [lexicalCategory] ([BaseInfo]): A linguistic category of words (or more precisely lexical items),
/// generally defined by the syntactic or morphological behaviour of the lexical item in question, such as
/// noun or verb ,
/// [noteList] ([BaseInfo], optional),
/// [pronunciationList] (List[Pronunciation], optional),
/// [text] (string): A given written or spoken realisation of an entry. ,
/// [variantFormList] (List[VariantForm], optional): Various words that are used interchangeably depending
/// on the context, e.g 'a' and 'an'
class LexicalEntry extends Equatable {
  final List<RelatedEntry> derivativeOfList, derivativeList;
  final List<Entry> entryList;
  final List<BaseInfo> grammaticalFeatureList;
  final String language, text;
  final BaseInfo lexicalCategory;
  final List<BaseInfo> noteList;
  final List<Pronunciation> pronunciationList;
  final List<VariantForm> variantFormList;

  LexicalEntry({
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
