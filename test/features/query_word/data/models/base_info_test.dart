import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final BaseInfo baseInfo = BaseInfo(
    id: "test id",
    text: "test text",
    type: "test type",
  );

  test('should return BaseInfo object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture('base_info_fixture.json'),
    );
    expect(BaseInfo.fromJson(jsonData), baseInfo);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = baseInfo.toJson();
    expect(jsonData, json.decode(fixture('base_info_fixture.json')));
  });
}
