import 'package:equatable/equatable.dart';

import 'sense.dart';
import 'pronunciation.dart';
import 'base_info.dart';
import 'variant_form.dart';

/// [Entry] class
/// [etymologyList] (List[String], optional): The origin of the word and the way in which its meaning has changed throughout history ,
/// [grammaticalFeatureList] (List[BaseInfo], optional),
/// [homographNumber] (string, optional): Identifies the homograph grouping. The last two digits identify different entries of the same homograph. The first one/two digits identify the homograph number. ,
/// [noteList] (List[BaseInfo], optional),
/// [pronunciationList] (List[Pronunciation], optional),
/// [senseList] (Array[Sense], optional): Complete list of senses ,
/// [variantForms] (List[VariantForm], optional): Various words that are used interchangeably depending on the context, e.g 'a' and 'an'
class Entry extends Equatable {
  final List<String> etymologyList;
  final List<BaseInfo> grammaticalFeatureList;
  final String homographNumber;
  final List<BaseInfo> noteList;
  final List<Pronunciation> pronunciationList;
  final List<Sense> senseList;
  final List<VariantForm> variantFormList;

  Entry({
    this.etymologyList,
    this.grammaticalFeatureList,
    this.homographNumber,
    this.noteList,
    this.pronunciationList,
    this.senseList,
    this.variantFormList,
  });

  @override
  List<Object> get props => [
        etymologyList,
        grammaticalFeatureList,
        homographNumber,
        noteList,
        pronunciationList,
        senseList,
        variantFormList,
      ];
}
