import 'package:equatable/equatable.dart';

import 'construction.dart';
import 'example.dart';
import 'pronunciation.dart';
import 'thesaurus_link.dart';
import 'variant_form.dart';
import 'base_info.dart';

/// [Sense] class
///
/// Properties:
/// [constructionList] (List[Construction], optional): A construction provides information about typical syntax
/// used of this sense. Each construction may optionally have one or more examples.
/// [crossReferenceMarkerList] (List[String], optional): A grouping of crossreference notes. ,
/// [crossReferenceList] (List[BaseInfo], optional),
/// [definitionList] (List[String], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (domainsList, optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [etymologyList] (List[String], optional): The origin of the word and the way in which its meaning has changed throughout history ,
/// [exampleList] (List[Example], optional),
/// [id] (string, optional): The id of the sense that is required for the delete procedure ,
/// [noteList] (List[BaseInfo], optional),
/// [pronunciationList] (List[Pronunciation], optional),
/// [regionList] (List[BaseInfo], optional): A particular area in which the Sense occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfo], optional): A level of language usage, typically with respect to formality. e.g. 'offensive', 'informal' ,
/// [shortDefinitions] (List[String], optional): A list of short statements of the exact meaning of a word ,
/// [subsenseList] (List[Sense], optional): Ordered list of subsenses of a sense ,
/// [thesaurusLinkList] (List[ThesaurusLink], optional): Ordered list of links to the Thesaurus Dictionary ,
/// [variantFormList] (List[VariantForm], optional): Various words that are used interchangeably depending on the context, e.g 'duck' and 'duck boat'
class Sense extends Equatable {
  final List<Construction> constructionList;
  final List<String> crossReferenceMarkerList;
  final List<BaseInfo> crossReferenceList;
  final List<String> definitionList;
  final List<BaseInfo> domainList;
  final List<String> etymologyList;
  final List<Example> exampleList;
  final String id;
  final List<BaseInfo> noteList;
  final List<Pronunciation> pronunciationList;
  final List<BaseInfo> regionList;
  final List<BaseInfo> registerList;
  final List<String> shortDefinitions;
  final List<Sense> subsenseList;
  final List<ThesaurusLink> thesaurusLinkList;
  final List<VariantForm> variantFormList;

  Sense({
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
  });

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





