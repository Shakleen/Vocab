import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/pronunciation_model.dart';
import 'package:vocab/features/query_word/domain/entities/pronunciation.dart';

import '../../fixtures/fixture_reader.dart';

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
  final String fixtureFileName = 'pronunciation_fixture.json';

  test('should be of type Pronunciation', () {
    expect(tPronunciation, isA<Pronunciation>());
  });

  test('should return PronunciationModel object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(PronunciationModel.fromJson(jsonData), tPronunciation);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tPronunciation.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}
