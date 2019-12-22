import 'package:equatable/equatable.dart';

import 'base_info.dart';
import 'pronunciation.dart';

/// [VariantForm] class
/// [domainList] (List[BaseInfo], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[BaseInfo], optional),
/// [pronunciationList] (List[Pronunciation], optional): A grouping of pronunciation information ,
/// [regionList] (List[BaseInfo], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[BaseInfo], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class VariantForm extends Equatable {
  final List<BaseInfo> domainList;
  final String text;
  final List<BaseInfo> regionList;
  final List<BaseInfo> registerList;
  final List<BaseInfo> noteList;
  final List<Pronunciation> pronunciationList;

  VariantForm({
    this.noteList,
    this.domainList,
    this.text,
    this.regionList,
    this.registerList,
    this.pronunciationList,
  });

  @override
  List<Object> get props => [
        noteList,
        domainList,
        text,
        regionList,
        registerList,
        pronunciationList,
      ];
}
