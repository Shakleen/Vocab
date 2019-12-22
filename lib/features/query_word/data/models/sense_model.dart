import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';

import 'construction_model.dart';
import 'example_model.dart';
import 'pronunciation_model.dart';
import 'thesaurus_link_model.dart';
import 'variant_form_model.dart';

/// [SenseModel] class
///
/// Properties:
/// [constructionList] (List[GrammaticalFeature], optional): A construction provides information about typical syntax
/// used of this sense. Each construction may optionally have one or more examples.
/// [crossReferenceMarkerList] (List[String], optional): A grouping of crossreference notes. ,
/// [crossReferenceList] (List[BaseInfoModel], optional),
/// [definitionList] (List[String], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (domainsList, optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [etymologyList] (List[String], optional): The origin of the word and the way in which its meaning has changed throughout history ,
/// [exampleList] (List[ExampleModel], optional),
/// [id] (string, optional): The id of the sense that is required for the delete procedure ,
/// [noteList] (List[BaseInfoModel], optional),
/// [pronunciationList] (List[PronunciationModel], optional),
/// [regionList] (List[BaseInfoModel], optional): A particular area in which the Sense occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfoModel], optional): A level of language usage, typically with respect to formality. e.g. 'offensive', 'informal' ,
/// [shortDefinitions] (List[String], optional): A list of short statements of the exact meaning of a word ,
/// [subsenseList] (List[SenseModel], optional): Ordered list of subsenses of a sense ,
/// [thesaurusLinkList] (List[ThesaurusLinkModel], optional): Ordered list of links to the Thesaurus Dictionary ,
/// [variantFormList] (List[VariantFormModel], optional): Various words that are used interchangeably depending on the context, e.g 'duck' and 'duck boat'
class SenseModel extends Equatable {
  final List<ConstructionModel> constructionList;
  final List<String> crossReferenceMarkerList;
  final List<BaseInfoModel> crossReferenceList;
  final List<String> definitionList;
  final List<BaseInfoModel> domainList;
  final List<String> etymologyList;
  final List<ExampleModel> exampleList;
  final String id;
  final List<BaseInfoModel> noteList;
  final List<PronunciationModel> pronunciationList;
  final List<BaseInfoModel> regionList;
  final List<BaseInfoModel> registerList;
  final List<String> shortDefinitions;
  final List<SenseModel> subsenseList;
  final List<ThesaurusLinkModel> thesaurusLinkList;
  final List<VariantFormModel> variantFormList;

  SenseModel([
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





