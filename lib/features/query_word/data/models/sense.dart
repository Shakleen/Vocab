import 'package:equatable/equatable.dart';

import 'pronunciation.dart';
import 'inline_models.dart';
import 'thesaurus_link.dart';

/// [Sense] class
///
/// Properties:
/// [constructionList] (List[InlineModel3], optional): A construction provides information about typical syntax
/// used of this sense. Each construction may optionally have one or more examples.
/// [crossReferenceMarkerList] (List[String], optional): A grouping of crossreference notes. ,
/// [crossReferenceList] (List[InlineModel9], optional),
/// [definitionList] (List[String], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (domainsList, optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [etymologyList] (List[String], optional): The origin of the word and the way in which its meaning has changed throughout history ,
/// [exampleList] (List[InlineModel10], optional),
/// [id] (string, optional): The id of the sense that is required for the delete procedure ,
/// [noteList] (List[InlineModel4], optional),
/// [pronunciationList] (List[Pronunciation], optional),
/// [regionList] (List[Region], optional): A particular area in which the Sense occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g. 'offensive', 'informal' ,
/// [shortDefinitions] (List[String], optional): A list of short statements of the exact meaning of a word ,
/// [subsenseList] (List[Sense], optional): Ordered list of subsenses of a sense ,
/// [thesaurusLinkList] (List[ThesaurusLink], optional): Ordered list of links to the Thesaurus Dictionary ,
/// [variantFormList] (List[InlineModel5], optional): Various words that are used interchangeably depending on the context, e.g 'duck' and 'duck boat'
class Sense extends Equatable {
  final List<InlineModel11> constructionList;
  final List<String> crossReferenceMarkerList;
  final List<InlineModel9> crossReferenceList;
  final List<String> definitionList;
  final List<Domain> domainList;
  final List<String> etymologyList;
  final List<InlineModel10> exampleList;
  final String id;
  final List<InlineModel4> noteList;
  final List<Pronunciation> pronunciationList;
  final List<Region> regionList;
  final List<Register> registerList;
  final List<String> shortDefinitions;
  final List<Sense> subsenseList;
  final List<ThesaurusLink> thesaurusLinkList;
  final List<InlineModel5> variantFormList;

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
