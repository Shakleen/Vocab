import 'package:equatable/equatable.dart';

import 'pronunciation.dart';
import 'entry.dart';
import 'inline_models.dart';

/// [LexicalEntry] class
///
/// Properties:
/// [derivativeOfList] (List[InlineModel2], optional): Other words from which this one derives ,
/// [derivativeList] (List[InlineModel2], optional): Other words from which their Sense derives ,
/// [entryList] (List[Entry], optional),
/// [grammaticalFeatureList] (List[InlineModel3], optional),
/// [language] (string): IANA language code ,
/// [lexicalCategory] ([Region]): A linguistic category of words (or more precisely lexical items),
/// generally defined by the syntactic or morphological behaviour of the lexical item in question, such as
/// noun or verb ,
/// [noteList] ([InlineModel4], optional),
/// [pronunciationList] (List[Pronunciation], optional),
/// [text] (string): A given written or spoken realisation of an entry. ,
/// [variantFormList] (List[InlineModel5], optional): Various words that are used interchangeably depending
/// on the context, e.g 'a' and 'an'
class LexicalEntry extends Equatable {
  final List<InlineModel2> derivativeOfList, derivativeList;
  final List<Entry> entryList;
  final List<InlineModel3> grammaticalFeatureList;
  final String language, text;
  final Region lexicalCategory;
  final List<InlineModel4> noteList;
  final List<Pronunciation> pronunciationList;
  final List<InlineModel5> variantFormList;

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
