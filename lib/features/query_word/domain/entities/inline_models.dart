import 'package:equatable/equatable.dart';

/// [InlineModel1] class
/// [audioFileUrl] (string, optional): The URL of the sound file ,
/// [dialectList] (List[string], optional): A local or regional variation where the pronunciation occurs,
/// e.g. 'British English' ,
/// [phoneticNotation] (string, optional): The alphabetic system used to display the phonetic spelling ,
/// [phoneticSpelling] (string, optional): Phonetic spelling is the representation of vocal sounds which
/// express pronunciations of words. It is a system of spelling in which each letter represents invariably
/// the same spoken sound ,
/// [regionList] (List[Region], optional): A particular area in which the pronunciation occurs, e.g.
/// 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to
/// formality. e.g. 'offensive', 'informal'
class InlineModel1 extends Equatable {
  final String audioFileUrl, phoneticNotation, phoneticSpelling;
  final List<String> dialectList;
  final List<Region> regionList;
  final List<Register> registerList;

  InlineModel1({
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

/// [InlineModel2] class
/// [domainList] (List[Domain], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [id] (string): he identifier of the word ,
/// [language] (string, optional): IANA language code specifying the language of the word ,
/// [regionList] (List[Region], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class InlineModel2 extends Equatable {
  final List<Domain> domainList;
  final String id, language, text;
  final List<Region> regionList;
  final List<Register> registerList;

  InlineModel2({
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

class InlineModel3 extends Equatable {
  final String id, text, type;

  InlineModel3({
    this.id,
    this.text,
    this.type,
  });

  @override
  List<Object> get props => [
        id,
        text,
        type,
      ];
}

/// [InlineModel4] class
/// [id] (string, optional): The identifier of the word ,
/// [text] (string): A note text ,
/// [type] (string): The descriptive category of the text
class InlineModel4 extends InlineModel3 {}

/// [InlineModel5] class
/// [domainList] (List[Domain], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[CategorizedText], optional),
/// [pronunciationList] (List[InlineModel1], optional): A grouping of pronunciation information ,
/// [regionList] (List[Region], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class InlineModel5 extends Equatable {
  final List<Domain> domainList;
  final String text;
  final List<Region> regionList;
  final List<Register> registerList;
  final List<CategorizedTextList> noteList;
  final List<InlineModel1> pronunciationList;

  InlineModel5({
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

class InlineModel6 extends Equatable {
  final String id, text;

  InlineModel6({this.id, this.text});

  @override
  List<Object> get props => [id, text];
}

class InlineModel7 extends InlineModel6 {}

class InlineModel8 extends InlineModel6 {}

/// [InlineModel9] class
/// [id] (string): The word id of the co-occurrence ,
/// [text] (string): The word of the co-occurrence ,
/// [type] (string): The type of relation between the two words. Possible values are 'close match', 'related',
/// 'see also', 'variant spelling', and 'abbreviation' in case of crossreferences, or 'pre', 'post' in case of collocates.
class InlineModel9 extends InlineModel3 {}

/// [InlineModel10] class
/// [definitionList] (List[strings], optional): A list of statements of the exact meaning of a word ,
/// [domainList] (List[Domain], optional): A subject, discipline, or branch of knowledge particular to the Sense ,
/// [noteList] (List[CategorizedText], optional),
/// [regionList] (List[Region], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g.
/// 'offensive', 'informal' ,
/// [senseIdList] (List[strings], optional): The list of sense identifiers related to the example. Provided in the
/// sentences endpoint only. ,
/// [text] (string)
class InlineModel10 extends Equatable {
  final List<Definition> definitionList;
  final List<Domain> domainList;
  final List<CategorizedTextList> noteList;
  final List<Region> regionList;
  final List<Register> registerList;
  final List<SenseId> senseIdList;
  final String text;

  InlineModel10({
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
