import 'package:vocab/features/query_word/domain/entities/example.dart';

import 'base_info_model.dart';

/// [ExampleModel] class
/// [definitionList] (List[strings], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (List[BaseInfoModel], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[CategorizedText], optional),
/// [regionList] (List[BaseInfoModel], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfoModel], optional): A level of language usage, typically with respect to formality. e.g.
/// 'offensive', 'informal' ,
/// [senseIdList] (List[strings], optional): The list of sense identifiers related to the example. Provided in the
/// sentences endpoint only. ,
/// [text] (string)
class ExampleModel extends Example {
  ExampleModel({
    List<String> definitionList,
    List<BaseInfoModel> domainList,
    List<BaseInfoModel> noteList,
    List<BaseInfoModel> regionList,
    List<BaseInfoModel> registerList,
    List<String> senseIdList,
    String text,
  }) : super(
          definitionList: definitionList,
          domainList: domainList,
          noteList: noteList,
          regionList: regionList,
          registerList: registerList,
          senseIdList: senseIdList,
          text: text,
        );

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
