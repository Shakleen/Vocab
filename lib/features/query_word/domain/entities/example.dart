import 'package:equatable/equatable.dart';

import 'base_info.dart';

/// [Example] class
/// [definitionList] (List[strings], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (List[BaseInfo], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[CategorizedText], optional),
/// [regionList] (List[BaseInfo], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfo], optional): A level of language usage, typically with respect to formality. e.g.
/// 'offensive', 'informal' ,
/// [senseIdList] (List[strings], optional): The list of sense identifiers related to the example. Provided in the
/// sentences endpoint only. ,
/// [text] (string)
class Example extends Equatable {
  final List<String> definitionList;
  final List<BaseInfo> domainList;
  final List<BaseInfo> noteList;
  final List<BaseInfo> regionList;
  final List<BaseInfo> registerList;
  final List<String> senseIdList;
  final String text;

  Example({
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