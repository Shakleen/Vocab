import 'package:equatable/equatable.dart';

import 'base_info.dart';

/// [RelatedEntry] class
/// [domainList] (List[BaseInfo], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [id] (string): he identifier of the word ,
/// [language] (string, optional): IANA language code specifying the language of the word ,
/// [regionList] (List[BaseInfo], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfo], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class RelatedEntry extends Equatable {
  final List<BaseInfo> domainList;
  final String id, language, text;
  final List<BaseInfo> regionList;
  final List<BaseInfo> registerList;

  RelatedEntry({
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