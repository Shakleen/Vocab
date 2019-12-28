import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/domain/entities/sense.dart';

import 'construction_model.dart';
import 'example_model.dart';
import 'object_converter.dart';
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

  factory SenseModel.fromJson(Map<String, dynamic> json) {
    return SenseModel(
      constructionList:
          ObjectConverter.toConstructionList(json['constructions']),
      crossReferenceMarkerList: ObjectConverter.toStringList(
        json['crossReferenceMarkers'],
      ),
      crossReferenceList:
          ObjectConverter.toBaseinfoList(json['crossReferences']),
      definitionList: ObjectConverter.toStringList(json['definitions']),
      domainList: ObjectConverter.toBaseinfoList(json['domains']),
      etymologyList: ObjectConverter.toStringList(json['etymologies']),
      exampleList: ObjectConverter.toExampleList(json['examples']),
      id: json['id'],
      noteList: ObjectConverter.toBaseinfoList(json['notes']),
      pronunciationList:
          ObjectConverter.toPronunciationList(json['pronunciations']),
      registerList: ObjectConverter.toBaseinfoList(json['registers']),
      regionList: ObjectConverter.toBaseinfoList(json['regions']),
      shortDefinitions: ObjectConverter.toStringList(json['shortDefinitions']),
      subsenseList: ObjectConverter.toSenseList(json['subsenses']),
      thesaurusLinkList:
          ObjectConverter.toThesaurusList(json['thesaurusLinks']),
      variantFormList: ObjectConverter.toVariantFormList(json['variantForms']),
    );
  }

  Map<String, dynamic> toJson() {
    final Function toString = (element) => element.toJson();
    final Map<String, dynamic> json = {};

    json['constructions'] = this.constructionList?.map(toString);
    json['subsenses'] = this.subsenseList?.map(toString);
    json['crossReferenceMarkers'] = this.crossReferenceMarkerList;
    json['crossReferences'] = this.crossReferenceList?.map(toString);
    json['definitions'] = this.definitionList;
    json['domains'] = this.domainList?.map(toString);
    json['etymologies'] = this.etymologyList;
    json['examples'] = this.exampleList?.map(toString);
    json['id'] = this.id;
    json['notes'] = this.noteList?.map(toString);
    json['pronunciations'] = this.pronunciationList?.map(toString);
    json['registers'] = this.registerList?.map(toString);
    json['regions'] = this.regionList?.map(toString);
    json['shortDefinitions'] = this.shortDefinitions;
    json['thesaurusLinks'] = this.thesaurusLinkList?.map(toString);
    json['variantForms'] = this.variantFormList?.map(toString);

    return json;
  }
}
