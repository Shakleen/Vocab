import 'package:equatable/equatable.dart';

import 'pronunciation.dart';
import 'inline_models.dart';
import 'thesaurus_link.dart';
import 'variant_form.dart';

/// [Sense] class
///
/// Properties:
/// [constructionList] (List[GrammaticalFeature], optional): A construction provides information about typical syntax
/// used of this sense. Each construction may optionally have one or more examples.
/// [crossReferenceMarkerList] (List[String], optional): A grouping of crossreference notes. ,
/// [crossReferenceList] (List[CrossReference], optional),
/// [definitionList] (List[String], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (domainsList, optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [etymologyList] (List[String], optional): The origin of the word and the way in which its meaning has changed throughout history ,
/// [exampleList] (List[_Example], optional),
/// [id] (string, optional): The id of the sense that is required for the delete procedure ,
/// [noteList] (List[Note], optional),
/// [pronunciationList] (List[Pronunciation], optional),
/// [regionList] (List[Region], optional): A particular area in which the Sense occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g. 'offensive', 'informal' ,
/// [shortDefinitions] (List[String], optional): A list of short statements of the exact meaning of a word ,
/// [subsenseList] (List[Sense], optional): Ordered list of subsenses of a sense ,
/// [thesaurusLinkList] (List[ThesaurusLink], optional): Ordered list of links to the Thesaurus Dictionary ,
/// [variantFormList] (List[VariantForm], optional): Various words that are used interchangeably depending on the context, e.g 'duck' and 'duck boat'
class Sense extends Equatable {
  final List<_Construction> constructionList;
  final List<String> crossReferenceMarkerList;
  final List<CrossReference> crossReferenceList;
  final List<String> definitionList;
  final List<Domain> domainList;
  final List<String> etymologyList;
  final List<_Example> exampleList;
  final String id;
  final List<Note> noteList;
  final List<Pronunciation> pronunciationList;
  final List<Region> regionList;
  final List<Register> registerList;
  final List<String> shortDefinitions;
  final List<Sense> subsenseList;
  final List<ThesaurusLink> thesaurusLinkList;
  final List<VariantForm> variantFormList;

  Sense([
    this.constructionList,
    this.crossReferenceMarkerList,
    this.crossReferenceList,
    this.definitionList,
    this.domainList,
    this.etymologyList,
    this.exampleList,
    this.id,
    this.noteList,
    this.pronunciationList,
    this.regionList,
    this.registerList,
    this.shortDefinitions,
    this.subsenseList,
    this.thesaurusLinkList,
    this.variantFormList,
  ]);

  @override
  List<Object> get props => [
        constructionList,
        crossReferenceMarkerList,
        crossReferenceList,
        definitionList,
        domainList,
        etymologyList,
        exampleList,
        id,
        noteList,
        pronunciationList,
        regionList,
        registerList,
        shortDefinitions,
        subsenseList,
        thesaurusLinkList,
        variantFormList,
      ];
}

/// [_Example] class
/// [definitionList] (List[strings], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (List[Domain], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[CategorizedText], optional),
/// [regionList] (List[Region], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g.
/// 'offensive', 'informal' ,
/// [senseIdList] (List[strings], optional): The list of sense identifiers related to the example. Provided in the
/// sentences endpoint only. ,
/// [text] (string)
class _Example extends Equatable {
  final List<String> definitionList;
  final List<Domain> domainList;
  final List<Note> noteList;
  final List<Region> regionList;
  final List<Register> registerList;
  final List<String> senseIdList;
  final String text;

  _Example({
    this.definitionList,
    this.domainList,
    this.noteList,
    this.regionList,
    this.registerList,
    this.senseIdList,
    this.text,
  });

  @override
  List<Object> get props => [
        definitionList,
        domainList,
        noteList,
        regionList,
        registerList,
        senseIdList,
        text,
      ];
}

class _Construction extends Equatable {
  final List<Domain> domainList;
  final List<String> exampleList;
  final List<Note> noteList;
  final List<Region> regionList;
  final List<Register> registerList;
  final String text;

  _Construction({
    this.domainList,
    this.exampleList,
    this.noteList,
    this.regionList,
    this.registerList,
    this.text,
  });

  @override
  List<Object> get props => [
        domainList,
        exampleList,
        noteList,
        regionList,
        registerList,
        text,
      ];
}

/// [CrossReference] class
/// [id] (string): The word id of the co-occurrence ,
/// [text] (string): The word of the co-occurrence ,
/// [type] (string): The type of relation between the two words. Possible values are 'close match', 'related',
/// 'see also', 'variant spelling', and 'abbreviation' in case of crossreferences, or 'pre', 'post' in case of collocates.
class CrossReference extends InlineModel2 {}