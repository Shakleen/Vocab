import 'package:equatable/equatable.dart';

class BaseInfo extends Equatable {
  final String id, text, type;

  BaseInfo({this.id, this.text, this.type});

  @override
  List<Object> get props => [id, text, type];

  factory BaseInfo.fromJson(Map<String, dynamic> jsonData) {
    return BaseInfo(
      id: jsonData['id'],
      text: jsonData['text'],
      type: jsonData['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = {};

    jsonData['id'] = this.id;
    jsonData['text'] = this.text;
    jsonData['type'] = this.type;

    return jsonData;
  }
}


