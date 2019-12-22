import 'package:equatable/equatable.dart';

class BaseInfoModel extends Equatable {
  final String id, text, type;

  BaseInfoModel({this.id, this.text, this.type});

  @override
  List<Object> get props => [id, text, type];

  factory BaseInfoModel.fromJson(Map<String, dynamic> jsonData) {
    return BaseInfoModel(
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


