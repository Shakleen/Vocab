import 'package:equatable/equatable.dart';

class BaseInfo extends Equatable {
  final String id, text, type;

  BaseInfo({this.id, this.text, this.type});

  @override
  List<Object> get props => [id, text, type];
}


