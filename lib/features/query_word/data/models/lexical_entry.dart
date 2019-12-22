import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/data/models/variant_form.dart';

import 'pronunciation.dart';
import 'entry.dart';
import 'inline_models.dart';

/// [LexicalEntry] class
///
/// Properties:
/// [derivativeOfList] (List[_RelatedEntry], optional): Other words from which this one derives ,
/// [derivativeList] (List[_RelatedEntry], optional): Other words from which their Sense derives ,
/// [entryList] (List[Entry], optional),
/// [grammaticalFeatureList] (List[GrammaticalFeature], optional),
/// [language] (string): IANA language code ,
/// [lexicalCategory] ([Region]): A linguistic category of words (or more precisely lexical items),
/// generally defined by the syntactic or morphological behaviour of the lexical item in question, such as
/// noun or verb ,
/// [noteList] ([Note], optional),
/// [pronunciationList] (List[Pronunciation], optional),
/// [text] (string): A given written or spoken realisation of an entry. ,
/// [variantFormList] (List[VariantForm], optional): Various words that are used interchangeably depending
/// on the context, e.g 'a' and 'an'
class LexicalEntry extends Equatable {
  final List<_RelatedEntry> derivativeOfList, derivativeList;
  final List<Entry> entryList;
  final List<GrammaticalFeature> grammaticalFeatureList;
  final String language, text;
  final Region lexicalCategory;
  final List<Note> noteList;
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

/// [_RelatedEntry] class
/// [domainList] (List[Domain], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [id] (string): he identifier of the word ,
/// [language] (string, optional): IANA language code specifying the language of the word ,
/// [regionList] (List[Region], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class _RelatedEntry extends Equatable {
  final List<Domain> domainList;
  final String id, language, text;
  final List<Region> regionList;
  final List<Register> registerList;

  _RelatedEntry({
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
