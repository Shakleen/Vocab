import 'package:equatable/equatable.dart';

import 'inline_models.dart';
import 'pronunciation.dart';

/// [VariantForm] class
/// [domainList] (List[Domain], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[Note], optional),
/// [pronunciationList] (List[Pronunciation], optional): A grouping of pronunciation information ,
/// [regionList] (List[Region], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class VariantForm extends Equatable {
  final List<Domain> domainList;
  final String text;
  final List<Region> regionList;
  final List<Register> registerList;
  final List<Note> noteList;
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