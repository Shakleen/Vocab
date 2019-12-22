import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/domain/entities/inline_models.dart';

/// [LexicalEntry] class
///
/// Properties:
/// [derivativeOfList] (List[_RelatedEntries], optional): Other words from which this one derives ,
/// [derivativeList] (List[_RelatedEntries], optional): Other words from which their Sense derives ,
/// [entryList] (List[Entry], optional),
/// [grammaticalFeatureList] (List[GrammaticalFeature], optional),
/// [language] (string): IANA language code ,
/// [lexicalCategory] ([LexicalCategory]): A linguistic category of words (or more precisely lexical items),
/// generally defined by the syntactic or morphological behaviour of the lexical item in question, such as
/// noun or verb ,
/// [noteList] ([CategorizedTextList], optional),
/// [pronunciationList] (List[InlineModel1], optional),
/// [text] (string): A given written or spoken realisation of an entry. ,
/// [variantFormList] (List[VariantForm], optional): Various words that are used interchangeably depending
/// on the context, e.g 'a' and 'an'
class LexicalEntry extends Equatable {
  final List<InlineModel2> derivativeOfList, derivativeList;
  final List<Entry> entryList;
  final List<GrammaticalFeature> grammaticalFeatureList;
  final String language, text;
  final LexicalCategory lexicalCategory;
  final List<CategorizedTextList> noteList;
  final List<InlineModel1> pronunciationList;
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
