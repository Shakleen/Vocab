import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/pronunciation_model.dart';
import 'package:vocab/features/query_word/data/models/variant_form_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final BaseInfoModel baseInfo = BaseInfoModel(
    id: "test id",
    text: "test text",
    type: "test type",
  );
  final PronunciationModel tPronunciation = PronunciationModel(
    audioFileUrl: "test.mp3",
    dialectList: ["test1", "test2", "test3"],
    phoneticNotation: "test phoneticNotation",
    phoneticSpelling: "test phoneticSpelling",
    regionList: [baseInfo, baseInfo, baseInfo],
    registerList: [baseInfo, baseInfo],
  );
  final VariantFormModel tVariantFormModel = VariantFormModel(
    domainList: [baseInfo, baseInfo, baseInfo],
    text: "test text",
    regionList: [baseInfo, baseInfo],
    registerList: [baseInfo],
    noteList: [baseInfo, baseInfo, baseInfo, baseInfo],
    pronunciationList: [tPronunciation, tPronunciation],
  );
  final String fixtureFileName = 'variant_form_fixture.json';

  test('should be of type VariantFormModel', () {
    expect(tVariantFormModel, isA<VariantFormModel>());
  });

  test('should return VariantFormModel object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(VariantFormModel.fromJson(jsonData), tVariantFormModel);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tVariantFormModel.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}
