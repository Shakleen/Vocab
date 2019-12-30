import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vocab/core/error/exceptions.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/network/network_info.dart';
import 'package:vocab/features/word_card/data/data_source/remote_dictionary.dart';
import 'package:vocab/features/word_card/data/repository/word_card_repository_impl.dart';
import 'package:vocab/features/word_card/data/models/pronunciation_model.dart';
import 'package:vocab/features/word_card/data/models/syllable_model.dart';
import 'package:vocab/features/word_card/data/models/word_details_model.dart';
import 'package:vocab/features/word_card/data/models/word_search_result_model.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockRemoteDictionary extends Mock implements RemoteDictionary {}

void main() {
  final String tQueryWord = "race";
  final WordSearchResultModel tWordSearchResultModel = _buildModel();
  MockNetworkInfo mockNetworkInfo;
  MockRemoteDictionary mockRemoteDictionary;
  WordCardRepositoryImpl repository;

  void setupOnlineTest() {
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
  }

  void setupProperResponse() {
    when(mockRemoteDictionary.getWordDetails(any)).thenAnswer(
      (_) async => tWordSearchResultModel,
    );
  }

  Failure matchExceptionToFailure(exception) {
    switch (exception.runtimeType) {
      case NotFoundException:
        return NotFoundFailure();
      case InvalidFilterException:
        return InvalidFilterFailure();
      case UnauthorizedException:
        return UnauthorizedFailure();
      case ServerException:
        return ServerFailure();
      case UnknownException:
        return UnknownFailure();
    }
  }

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDictionary = MockRemoteDictionary();
    repository = WordCardRepositoryImpl(
      networkInfo: mockNetworkInfo,
      remoteDictionary: mockRemoteDictionary,
    );
  });

  test('should call NetworkInfo to check network status', () async {
    setupOnlineTest();
    await repository.getWordInformation(tQueryWord);
    verify(mockNetworkInfo.isConnected);
  });

  group('Online tests', () {
    test('should call RemoteDatabase', () async {
      setupOnlineTest();
      setupProperResponse();
      await repository.getWordInformation(tQueryWord);
      verify(mockRemoteDictionary.getWordDetails(tQueryWord));
    });

    test('should return WordSearchResult', () async {
      setupOnlineTest();
      setupProperResponse();
      final result = await repository.getWordInformation(tQueryWord);
      expect(result, Right(tWordSearchResultModel));
    });

    void testExceptionCase(exception) {
      test('should return Failure object for ${exception.runtimeType}', () async {
        setupOnlineTest();
        when(mockRemoteDictionary.getWordDetails(any)).thenThrow(exception);
        final result = await repository.getWordInformation(tQueryWord);
        expect(result, Left(matchExceptionToFailure(exception)));
      });
    }

    testExceptionCase(NotFoundException());
    testExceptionCase(InvalidFilterException());
    testExceptionCase(UnauthorizedException());
    testExceptionCase(ServerException());
    testExceptionCase(UnknownException());
  });

  group('Offline test', () {
    test('should return OfflineFailure when device is offline', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      final result = await repository.getWordInformation(tQueryWord);
      expect(result, Left(DeviceOfflineFailure()));
    });
  });
}

WordSearchResultModel _buildModel() {
  return WordSearchResultModel(
    word: "race",
    frequency: 4.75,
    pronunciation: PronunciationModel(all: "res"),
    syllables: SyllableModel(count: 1, list: ["race"]),
    results: [
      WordDetailsModel(
          definition: "compete in a race",
          partOfSpeech: "verb",
          synonymList: [
            "run"
          ],
          typeOfList: [
            "compete",
            "vie",
            "contend"
          ],
          hasTypeList: [
            "horse-race",
            "boat-race",
            "campaign",
            "place",
            "run",
            "show",
            "speed skate"
          ],
          derivationList: [
            "racer",
            "racing"
          ],
          exampleList: [
            "let's race and see who gets there first"
          ]),
      WordDetailsModel(
          definition:
              "the flow of air that is driven backwards by an aircraft propeller",
          partOfSpeech: "noun",
          synonymList: ["airstream", "backwash", "slipstream", "wash"],
          typeOfList: ["flow"]),
      WordDetailsModel(
          definition: "cause to move fast or to rush or race",
          partOfSpeech: "verb",
          synonymList: ["rush"],
          typeOfList: ["move", "displace"],
          derivationList: ["racer"],
          exampleList: ["The psychologist raced the rats through a long maze"]),
      WordDetailsModel(
          definition: "move hurridly",
          partOfSpeech: "verb",
          synonymList: [
            "belt along",
            "bucket along",
            "cannonball along",
            "hasten",
            "hie",
            "hotfoot",
            "pelt along",
            "rush",
            "rush along",
            "speed",
            "step on it"
          ],
          typeOfList: [
            "go",
            "travel",
            "locomote",
            "move"
          ],
          hasTypeList: [
            "flash",
            "barge",
            "buck",
            "dash",
            "dart",
            "shoot",
            "shoot down",
            "charge",
            "tear",
            "push forward",
            "thrust ahead",
            "scoot",
            "scud"
          ],
          exampleList: [
            "The cars raced down the street"
          ]),
      WordDetailsModel(
          definition: "a canal for a current of water",
          partOfSpeech: "noun",
          synonymList: ["raceway"],
          typeOfList: ["canal"]),
      WordDetailsModel(
          definition:
              "(biology) a taxonomic group that is a division of a species; usually arises as a consequence of geographical isolation within a species",
          partOfSpeech: "noun",
          synonymList: ["subspecies"],
          inCategoryList: ["biological science", "biology"],
          typeOfList: ["taxonomic group", "taxon", "taxonomic category"]),
      WordDetailsModel(
          definition: "a contest of speed",
          partOfSpeech: "noun",
          typeOfList: [
            "contest",
            "competition"
          ],
          hasTypeList: [
            "bicycle race",
            "bike race",
            "boat race",
            "burnup",
            "relay race",
            "auto race",
            "automobile race",
            "chariot race",
            "cross country",
            "dog racing",
            "foot race",
            "footrace",
            "freestyle",
            "heat",
            "horse race",
            "potato race",
            "relay",
            "repechage",
            "run",
            "sack race",
            "scratch race",
            "ski race",
            "skiing race",
            "car race"
          ],
          derivationList: [
            "racy"
          ],
          exampleList: [
            "the race is to the swift"
          ]),
      WordDetailsModel(
          definition: "any competition",
          partOfSpeech: "noun",
          typeOfList: ["competition", "contest"],
          hasTypeList: ["campaign", "political campaign", "run", "arms race"],
          exampleList: ["the race for the presidency"]),
      WordDetailsModel(
          definition:
              "people who are believed to belong to the same genetic stock",
          partOfSpeech: "noun",
          typeOfList: [
            "group",
            "grouping"
          ],
          hasTypeList: [
            "master race",
            "herrenvolk"
          ],
          derivationList: [
            "racial"
          ],
          exampleList: [
            "some biologists doubt that there are important genetic differences between races of human beings"
          ]),
      WordDetailsModel(
          definition:
              "to work as fast as possible towards a goal, sometimes in competition with others",
          partOfSpeech: "verb",
          typeOfList: ["move", "act"]),
    ],
  );
}
