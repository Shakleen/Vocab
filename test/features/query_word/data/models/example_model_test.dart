import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/example_model.dart';
import 'package:vocab/features/query_word/domain/entities/example.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final BaseInfoModel baseInfo = BaseInfoModel(
    id: "test id",
    text: "test text",
    type: "test type",
  );
  final ExampleModel tExampleModel = ExampleModel(
    domainList: [baseInfo, baseInfo, baseInfo],
    text: "test text",
    regionList: [baseInfo, baseInfo],
    registerList: [baseInfo],
    noteList: [baseInfo, baseInfo, baseInfo, baseInfo],
    definitionList: [
      "test definition",
      "test definition",
      "test definition",
      "test definition",
      "test definition",
    ],
    senseIdList: [
      "test sense",
      "test sense",
      "test sense",
      "test sense",
      "test sense",
    ],
  );
  final String fixtureFileName = 'example_fixture.json';

  test('should be of type Example', () {
    expect(tExampleModel, isA<Example>());
  });

  test('should return ExampleModel object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(ExampleModel.fromJson(jsonData), tExampleModel);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tExampleModel.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}
