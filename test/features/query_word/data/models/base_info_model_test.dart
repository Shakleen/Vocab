import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/domain/entities/base_info.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final BaseInfoModel tBaseInfo = BaseInfoModel(
    id: "test id",
    text: "test text",
    type: "test type",
  );
  final String fixtureFileName = 'base_info_fixture.json';

  test('should be of type BaseInfo', () {
    expect(tBaseInfo, isA<BaseInfo>());
  });

  test('should return BaseInfo object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(BaseInfoModel.fromJson(jsonData), tBaseInfo);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tBaseInfo.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}
