import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/util/input_converter.dart';
import 'package:vocab/features/query_word/domain/usecases/get_word_definition.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
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

class MockGetWordDefinition extends Mock implements GetWordDefinition {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  MockGetWordDefinition mockGetWordDefinition;
  MockInputConverter mockInputConverter;
  QueryWordBloc bloc;
  final String tQueryWord = "Test";
  final String tQueryWordLower = "test";
  final RetrieveEntryModel retrieveEntryModel = _buildTestModel();

  void setupValidInputConversion() {
    when(mockInputConverter.convertToLower(any))
        .thenReturn(Right(tQueryWordLower));
  }

  setUp(() {
    mockGetWordDefinition = MockGetWordDefinition();
    mockInputConverter = MockInputConverter();
    bloc = QueryWordBloc(
      retriever: mockGetWordDefinition,
      inputConverter: mockInputConverter,
    );
  });

  test('initial state should be [EmptyState]', () {
    expect(bloc.initialState, equals(Empty()));
  });

  test('should call InputConverter to validate and convert input string',
      () async {
    setupValidInputConversion();
    bloc.add(GetWordEntryEvent(queryWord: tQueryWord));
    await untilCalled(mockInputConverter.convertToLower(any));
    verify(mockInputConverter.convertToLower(tQueryWord));
  });

  blocTest(
    'should emit [Empty, ErrorState] when input is invalid',
    build: () {
      when(mockInputConverter.convertToLower(any))
          .thenReturn(Left(InvalidInputFailure()));
      return QueryWordBloc(
        inputConverter: mockInputConverter,
        retriever: mockGetWordDefinition,
      );
    },
    act: (QueryWordBloc bloc) async => bloc.add(
      GetWordEntryEvent(queryWord: tQueryWord),
    ),
    expect: [Empty(), Error(message: INVALID_INPUT_ERROR_MESSAGE)],
  );

  test('should call GetWordDefinition usecase to get word entry data',
      () async {
    setupValidInputConversion();
    when(mockGetWordDefinition(any)).thenAnswer(
      (_) async => Right(retrieveEntryModel),
    );
    bloc.add(GetWordEntryEvent(queryWord: tQueryWord));
    await untilCalled(mockGetWordDefinition(any));
    verify(mockGetWordDefinition(Param(queryWord: tQueryWordLower)));
  });

  blocTest(
    'should emit [Empty, Loading, Loaded] when input is valid',
    build: () {
      setupValidInputConversion();
      when(mockGetWordDefinition(any)).thenAnswer(
        (_) async => Right(retrieveEntryModel),
      );
      return QueryWordBloc(
        inputConverter: mockInputConverter,
        retriever: mockGetWordDefinition,
      );
    },
    act: (QueryWordBloc bloc) async => bloc.add(
      GetWordEntryEvent(queryWord: tQueryWord),
    ),
    expect: [
      Empty(),
      Loading(),
      Loaded(retrieveEntry: retrieveEntryModel),
    ],
  );

  void testBlocError(Failure failure, String message) {
    blocTest(
      'should emit [Empty, Loading, Error($message)] when data fetching fails',
      build: () {
        setupValidInputConversion();
        when(mockGetWordDefinition(any)).thenAnswer(
          (_) async => Left(failure),
        );
        return QueryWordBloc(
          inputConverter: mockInputConverter,
          retriever: mockGetWordDefinition,
        );
      },
      act: (QueryWordBloc bloc) async => bloc.add(
        GetWordEntryEvent(queryWord: tQueryWord),
      ),
      expect: [Empty(), Loading(), Error(message: message)],
    );
  }

  testBlocError(DeviceOfflineFailure(), DEVICE_OFFLINE_ERROR_MESSAGE);
  testBlocError(NotFoundFailure(), NOT_FOUND_ERROR_MESSAGE);
  testBlocError(InvalidFilterFailure(), INVALID_FILTER_ERROR_MESSAGE);
  testBlocError(TooLongURLFailure(), TOO_LONG_URL_ERROR_MESSAGE);
  testBlocError(ServerFailure(), SERVER_FAILURE_ERROR_MESSAGE);
  testBlocError(UnknownFailure(), UNKNOWN_ERROR_MESSAGE);
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
