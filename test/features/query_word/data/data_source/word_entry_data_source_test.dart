import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:vocab/core/error/exceptions.dart';
import 'package:vocab/features/query_word/data/data_source/word_entry_data_source.dart';
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

import '../../../../fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  WordEntryDataSource wordEntryDataSource;
  final RetrieveEntryModel expected = _buildTestModel();
  final String tQueryWord = "Test word";
  void setUpMockHttpClientResponse200() {
    final String fixturePath = 'test/features/query_word/fixtures/retrieve_entry_fixture.json';
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture(fixturePath), 200),
    );
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    wordEntryDataSource = OxfordWordEntryDataSource(client: mockHttpClient);
  });

  test(
    'should perform get request on a URL with word being the end point and with application/json header',
    () {
      setUpMockHttpClientResponse200();
      wordEntryDataSource.getWordEntry(tQueryWord);
      verify(
        mockHttpClient.get(
          wordEntryDataSource.entryApiUrl + tQueryWord + '?strictMatch=false',
          headers: {
            'Content-Type': 'application/json',
            'app_id': wordEntryDataSource.appID,
            'app_key': wordEntryDataSource.appKey,
          },
        ),
      );
    },
  );

  test(
    'should return RetrieveModel when response code is 200',
    () async {
      setUpMockHttpClientResponse200();
      final result = await wordEntryDataSource.getWordEntry(tQueryWord);
      expect(result, equals(expected));
    },
  );

  void testExceptionCase<T>(code) {
    test(
      'should throw ${T.runtimeType} when response code is $code',
      () async {
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response('Word not found!', code),
        );
        final call = wordEntryDataSource.getWordEntry;
        expect(() => call(tQueryWord), throwsA(isInstanceOf<T>()));
      },
    );
  }

  testExceptionCase<InvalidFilterException>(400);
  testExceptionCase<NotFoundException>(404);
  testExceptionCase<TooLongURLException>(414);
  testExceptionCase<ServerException>(500);
  testExceptionCase<UnknownException>(100);
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
