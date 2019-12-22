import 'package:equatable/equatable.dart';
import 'package:vocab/features/query_word/domain/entities/base_info.dart';

/// [Pronunciation] class
/// [audioFileUrl] (string, optional): The URL of the sound file ,
/// [dialectList] (List[string], optional): A local or regional variation where the pronunciation occurs,
/// e.g. 'British English' ,
/// [phoneticNotation] (string, optional): The alphabetic system used to display the phonetic spelling ,
/// [phoneticSpelling] (string, optional): Phonetic spelling is the representation of vocal sounds which
/// express pronunciations of words. It is a system of spelling in which each letter represents invariably
/// the same spoken sound ,
/// [regionList] (List[BaseInfo], optional): A particular area in which the pronunciation occurs, e.g.
/// 'Great Britain' ,
/// [registerList] (List[BaseInfo], optional): A level of language usage, typically with respect to
/// formality. e.g. 'offensive', 'informal'
class Pronunciation extends Equatable {
  final String audioFileUrl, phoneticNotation, phoneticSpelling;
  final List<String> dialectList;
  final List<BaseInfo> regionList;
  final List<BaseInfo> registerList;

  Pronunciation({
    this.audioFileUrl,
    this.phoneticNotation,
    this.phoneticSpelling,
    this.dialectList,
    this.regionList,
    this.registerList,
  });

  @override
  List<Object> get props => [
        this.audioFileUrl,
        this.phoneticNotation,
        this.phoneticSpelling,
        this.dialectList,
        this.regionList,
        this.registerList,
      ];
}
