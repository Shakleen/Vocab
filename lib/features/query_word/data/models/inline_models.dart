import 'package:equatable/equatable.dart';

import 'pronunciation.dart';

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
/// [noteList] (List[InlineModel4], optional),
/// [pronunciationList] (List[Pronunciation], optional): A grouping of pronunciation information ,
/// [regionList] (List[Region], optional): A particular area in which the pronunciation occurs, e.g. 'Great Britain' ,
/// [registerList] (List[Register], optional): A level of language usage, typically with respect to formality. e.g. '
/// offensive', 'informal' ,
/// [text] (string)
class InlineModel5 extends Equatable {
  final List<Domain> domainList;
  final String text;
  final List<Region> regionList;
  final List<Register> registerList;
  final List<InlineModel4> noteList;
  final List<Pronunciation> pronunciationList;

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

class InlineModel1 extends Equatable {
  final String id, text;

  InlineModel1({this.id, this.text});

  @override
  List<Object> get props => [id, text];
}

class Region extends InlineModel1 {}

class Register extends InlineModel1 {}

class Domain extends InlineModel1 {}

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
  final List<String> definitionList;
  final List<Domain> domainList;
  final List<InlineModel4> noteList;
  final List<Region> regionList;
  final List<Register> registerList;
  final List<String> senseIdList;
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

class InlineModel11 extends Equatable {
  final List<Domain> domainList;
  final List<String> exampleList;
  final List<InlineModel4> noteList;
  final List<Region> regionList;
  final List<Register> registerList;
  final String text;

  InlineModel11({
    this.domainList,
    this.exampleList,
    this.noteList,
    this.regionList,
    this.registerList,
    this.text,
  });

  @override
  List<Object> get props => [
        domainList,
        exampleList,
        noteList,
        regionList,
        registerList,
        text,
      ];
}
