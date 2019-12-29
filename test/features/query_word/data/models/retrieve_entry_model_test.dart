import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/base_info_model.dart';
import 'package:vocab/features/query_word/data/models/construction_model.dart';
import 'package:vocab/features/query_word/data/models/entry_model.dart';
import 'package:vocab/features/query_word/data/models/example_model.dart';
import 'package:vocab/features/query_word/data/models/headword_entry_model.dart';
import 'package:vocab/features/query_word/data/models/lexical_entry_model.dart';
import 'package:vocab/features/query_word/data/models/pronunciation_model.dart';
import 'package:vocab/features/query_word/data/models/related_entry_model.dart';
import 'package:vocab/features/query_word/data/models/retrieve_entry_model.dart';
import 'package:vocab/features/query_word/data/models/sense_model.dart';
import 'package:vocab/features/query_word/data/models/thesaurus_link_model.dart';
import 'package:vocab/features/query_word/data/models/variant_form_model.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';

import '../../../../fixture_reader.dart';

void main() {
  final RetrieveEntryModel tRetrieveModel = _buildTestModel();
  final String fixtureFileName = 'test/features/query_word/fixtures/retrieve_entry_fixture.json';

  test('should be of type RetrieveEntryModel', () {
    expect(tRetrieveModel, isA<RetrieveEntry>());
  });

  test('should return RetrieveEntryModel object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(RetrieveEntryModel.fromJson(jsonData), tRetrieveModel);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tRetrieveModel.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}

RetrieveEntryModel _buildTestModel() {
  final List<String> etymologyList = [
    "test etymology",
    "test etymology",
    "test etymology",
  ];
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
  final SenseModel tSenseModel = SenseModel(
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
    etymologyList: etymologyList,
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
  final EntryModel tEntryModel = EntryModel(
    etymologyList: etymologyList,
    grammaticalFeatureList: [tBaseInfo, tBaseInfo],
    homographNumber: "test homographNumber",
    noteList: [tBaseInfo, tBaseInfo],
    senseList: [tSenseModel, tSenseModel],
    variantFormList: [tVariantFormModel, tVariantFormModel],
    pronunciationList: [tPronunciation, tPronunciation],
  );
  final RelatedEntryModel tRelatedEntryModel = RelatedEntryModel(
    id: "test id",
    language: "test english",
    text: "test text",
    domainList: [tBaseInfo, tBaseInfo, tBaseInfo],
    regionList: [tBaseInfo, tBaseInfo],
    registerList: [tBaseInfo],
  );
  final LexicalEntryModel tLexicalEntryModel = LexicalEntryModel(
    derivativeList: [tRelatedEntryModel, tRelatedEntryModel],
    derivativeOfList: [tRelatedEntryModel, tRelatedEntryModel],
    entryList: [tEntryModel, tEntryModel],
    grammaticalFeatureList: [tBaseInfo, tBaseInfo],
    language: "test english",
    text: "test text",
    lexicalCategory: tBaseInfo,
    noteList: [tBaseInfo, tBaseInfo],
    pronunciationList: [tPronunciation, tPronunciation],
    variantFormList: [tVariantFormModel, tVariantFormModel],
  );
  final HeadwordEntryModel tHeadwordEntryModel = HeadwordEntryModel(
    id: "test id",
    language: "test language",
    word: "test word",
    type: "headword",
    lexicalEntryList: [tLexicalEntryModel, tLexicalEntryModel],
    pronunciationList: [tPronunciation, tPronunciation],
  );
  return RetrieveEntryModel(
    metaData: {
        "operation": "retrieve",
        "provider": "Oxford University Press",
        "schema": "RetrieveEntry"
    },
    id: "test id",
    word: "test word",
    resultList: [
      tHeadwordEntryModel,
      tHeadwordEntryModel,
      tHeadwordEntryModel,
      tHeadwordEntryModel,
    ],
  );
}
