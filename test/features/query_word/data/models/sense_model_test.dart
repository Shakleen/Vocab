import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/construction_model.dart';
import 'package:vocab/features/query_word/data/models/example_model.dart';
import 'package:vocab/features/query_word/data/models/pronunciation_model.dart';
import 'package:vocab/features/query_word/data/models/sense_model.dart';
import 'package:vocab/features/query_word/data/models/thesaurus_link_model.dart';
import 'package:vocab/features/query_word/data/models/variant_form_model.dart';
import 'package:vocab/features/query_word/domain/entities/sense.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final SenseModel tSenseModelWithNoSubsense = _buildTestModel();

  test('should be of type Sense', () {
    expect(tSenseModelWithNoSubsense, isA<Sense>());
  });

  group('without subsense', () {
    final String fixtureFileName = 'sense_without_subsense_fixture.json';

    test('should return SenseModel object after fromJson', () {
      final Map<String, dynamic> jsonData = json.decode(
        fixture(fixtureFileName),
      );
      expect(SenseModel.fromJson(jsonData), tSenseModelWithNoSubsense);
    });

    test('should return json object after toJson', () {
      final Map<String, dynamic> jsonData = tSenseModelWithNoSubsense.toJson();
      expect(jsonData, json.decode(fixture(fixtureFileName)));
    });
  });

  group('With subsenses', () {
    final SenseModel tSenseModelWithSubsense = _buildTestModel();
    tSenseModelWithSubsense.subsenseList.add(_buildTestModel());
    tSenseModelWithSubsense.subsenseList.add(_buildTestModel());

    final String fixtureFileName = 'sense_with_subsense_fixture.json';

    test('should return SenseModel object after fromJson', () {
      final Map<String, dynamic> jsonData = json.decode(
        fixture(fixtureFileName),
      );
      expect(SenseModel.fromJson(jsonData), tSenseModelWithSubsense);
    });

    test('should return json object after toJson', () {
      final Map<String, dynamic> jsonData = tSenseModelWithSubsense.toJson();
      expect(jsonData, json.decode(fixture(fixtureFileName)));
    });
  });
}

SenseModel _buildTestModel() {
  final BaseInfoModel tBaseInfo = BaseInfoModel(
    id: "test id",
    text: "test text",
    type: "test type",
  );
  final ExampleModel tExampleModel = ExampleModel(
    domainList: [tBaseInfo, tBaseInfo, tBaseInfo],
    text: "test text",
    regionList: [tBaseInfo, tBaseInfo],
    registerList: [tBaseInfo],
    noteList: [tBaseInfo, tBaseInfo, tBaseInfo, tBaseInfo],
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
  final PronunciationModel tPronunciation = PronunciationModel(
    audioFileUrl: "test.mp3",
    dialectList: ["test1", "test2", "test3"],
    phoneticNotation: "test phoneticNotation",
    phoneticSpelling: "test phoneticSpelling",
    regionList: [tBaseInfo, tBaseInfo, tBaseInfo],
    registerList: [tBaseInfo, tBaseInfo],
  );
  final VariantFormModel tVariantFormModel = VariantFormModel(
    domainList: [tBaseInfo, tBaseInfo, tBaseInfo],
    text: "test text",
    regionList: [tBaseInfo, tBaseInfo],
    registerList: [tBaseInfo],
    noteList: [tBaseInfo, tBaseInfo, tBaseInfo, tBaseInfo],
    pronunciationList: [tPronunciation, tPronunciation],
  );
  final ConstructionModel tConstructionModel = ConstructionModel(
    domainList: [tBaseInfo, tBaseInfo, tBaseInfo],
    exampleList: [
      "test example 1",
      "test example 2",
      "test example 3",
      "test example 4",
    ],
    noteList: [tBaseInfo, tBaseInfo, tBaseInfo, tBaseInfo],
    regionList: [tBaseInfo, tBaseInfo],
    registerList: [tBaseInfo],
    text: "test text",
  );
  final ThesaurusLinkModel tThesaurusLinkModel = ThesaurusLinkModel(
    entryId: "test entry id",
    senseId: "test sense id",
  );

  return SenseModel(
    constructionList: [tConstructionModel],
    crossReferenceMarkerList: [
      "test cross reference marker",
      "test cross reference marker",
      "test cross reference marker",
      "test cross reference marker",
    ],
    crossReferenceList: [tBaseInfo, tBaseInfo, tBaseInfo, tBaseInfo],
    definitionList: [
      "test definition",
      "test definition",
      "test definition",
      "test definition",
    ],
    domainList: [tBaseInfo, tBaseInfo],
    etymologyList: [
      "test etymology",
      "test etymology",
      "test etymology",
    ],
    exampleList: [tExampleModel, tExampleModel],
    id: "test id",
    noteList: [tBaseInfo, tBaseInfo],
    pronunciationList: [tPronunciation, tPronunciation],
    regionList: [tBaseInfo, tBaseInfo],
    registerList: [tBaseInfo, tBaseInfo],
    shortDefinitions: [
      "test short definition",
      "test short definition",
      "test short definition",
      "test short definition",
    ],
    subsenseList: [],
    thesaurusLinkList: [tThesaurusLinkModel, tThesaurusLinkModel],
    variantFormList: [tVariantFormModel, tVariantFormModel],
  );
}
