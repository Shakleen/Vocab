import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/related_entry_model.dart';
import 'package:vocab/features/query_word/domain/entities/related_entry.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final BaseInfoModel baseInfo = BaseInfoModel(
    id: "test id",
    text: "test text",
    type: "test type",
  );
  final RelatedEntryModel tRelatedEntryModel = RelatedEntryModel(
    id: "test id",
    language: "test english",
    text: "test text",
    domainList: [baseInfo, baseInfo, baseInfo],
    regionList: [baseInfo, baseInfo],
    registerList: [baseInfo],
  );
  final String fixtureFileName = 'related_entry_fixture.json';

  test('should be of type RelatedEntry', () {
    expect(tRelatedEntryModel, isA<RelatedEntry>());
  });

  test('should return RelatedEntry object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(RelatedEntryModel.fromJson(jsonData), tRelatedEntryModel);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tRelatedEntryModel.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}
