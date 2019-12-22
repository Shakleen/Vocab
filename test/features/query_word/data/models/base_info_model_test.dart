import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final BaseInfoModel baseInfo = BaseInfoModel(
    id: "test id",
    text: "test text",
    type: "test type",
  );
  final String fixtureFileName = 'base_info_fixture.json';

  test('should return BaseInfo object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(BaseInfoModel.fromJson(jsonData), baseInfo);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = baseInfo.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}
