import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/domain/entities/sense.dart';

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
class SenseModel extends Sense {
  SenseModel({
    List<ConstructionModel> constructionList,
    List<String> crossReferenceMarkerList,
    List<BaseInfoModel> crossReferenceList,
    List<String> definitionList,
    List<BaseInfoModel> domainList,
    List<String> etymologyList,
    List<ExampleModel> exampleList,
    String id,
    List<BaseInfoModel> noteList,
    List<PronunciationModel> pronunciationList,
    List<BaseInfoModel> regionList,
    List<BaseInfoModel> registerList,
    List<String> shortDefinitions,
    List<SenseModel> subsenseList,
    List<ThesaurusLinkModel> thesaurusLinkList,
    List<VariantFormModel> variantFormList,
  }) : super(
          constructionList: constructionList,
          crossReferenceMarkerList: crossReferenceMarkerList,
          crossReferenceList: crossReferenceList,
          definitionList: definitionList,
          domainList: domainList,
          etymologyList: etymologyList,
          exampleList: exampleList,
          id: id,
          noteList: noteList,
          pronunciationList: pronunciationList,
          regionList: regionList,
          registerList: registerList,
          shortDefinitions: shortDefinitions,
          subsenseList: subsenseList,
          thesaurusLinkList: thesaurusLinkList,
          variantFormList: variantFormList,
        );

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
