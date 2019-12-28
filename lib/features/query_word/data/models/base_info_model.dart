import 'package:vocab/features/query_word/domain/entities/base_info.dart';

class BaseInfoModel extends BaseInfo {
  BaseInfoModel({String id, String text, String type})
      : super(id: id, text: text, type: type);

  factory BaseInfoModel.fromJson(Map<String, dynamic> json) =>
      BaseInfoModel(id: json['id'], text: json['text'], type: json['type']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    json['id'] = this.id;
    json['text'] = this.text;
    json['type'] = this.type;

    return json;
  }
}
