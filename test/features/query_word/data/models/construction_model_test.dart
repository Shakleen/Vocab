import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/construction_model.dart';
import 'package:vocab/features/query_word/domain/entities/construction.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final BaseInfoModel baseInfo = BaseInfoModel(
    id: "test id",
    text: "test text",
    type: "test type",
  );
  final ConstructionModel tConstructionModel = ConstructionModel(
    domainList: [baseInfo, baseInfo, baseInfo],
    exampleList: [
      "test example 1",
      "test example 2",
      "test example 3",
      "test example 4",
    ],
    noteList: [baseInfo, baseInfo, baseInfo, baseInfo],
    regionList: [baseInfo, baseInfo],
    registerList: [baseInfo],
    text: "test text",
  );
  final String fixtureFileName = 'construction_fixture.json';

  test('should be of type Construction', () {
    expect(tConstructionModel, isA<Construction>());
  });

  test('should return ConstructionModel object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(ConstructionModel.fromJson(jsonData), tConstructionModel);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tConstructionModel.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}
