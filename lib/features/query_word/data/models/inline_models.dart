import 'package:equatable/equatable.dart';

class InlineModel2 extends Equatable {
  final String id, text, type;

  InlineModel2({this.id, this.text, this.type});

  @override
  List<Object> get props => [id, text, type];
}

class GrammaticalFeature extends InlineModel2 {}

/// [Note] class
/// [id] (string, optional): The identifier of the word ,
/// [text] (string): A note text ,
/// [type] (string): The descriptive category of the text
class Note extends InlineModel2 {}

class InlineModel1 extends Equatable {
  final String id, text;

  InlineModel1({this.id, this.text});

  @override
  List<Object> get props => [id, text];
}

class Region extends InlineModel1 {}

class Register extends InlineModel1 {}

class Domain extends InlineModel1 {}


