import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/entities/word_card_details.dart';
import 'package:vocab/core/error/error_messages.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/util/input_converter.dart';
import 'package:vocab/core/entities/syllable.dart';
import 'package:vocab/core/entities/pronunciation.dart';
import 'package:vocab/features/word_card/domain/usecase/get_word_card.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';
import 'package:vocab/features/word_card/presentation/bloc/word_card_bloc.dart';

class MockInputConverter extends Mock implements InputConverter {}

class MockGetWordCard extends Mock implements GetWordCard {}

void main() {
  final String tQueryWord = "Race";
  final String tQueryWordLower = "race";
  final WordCard tWordCard = _buildWordCard();
  WordCardBloc bloc;
  MockGetWordCard mockGetWordCard;
  MockInputConverter mockInputConverter;

  void setupValidInputConversion() {
    when(mockInputConverter.convertToLower(any))
        .thenReturn(Right(tQueryWordLower));
  }

  void setupValidResponse() {
    when(mockGetWordCard(any)).thenAnswer((_) async => Right(tWordCard));
  }

  Future<void> setupBlocAct(WordCardBloc bloc) async => bloc.add(
        GetWordCardEvent(queryWord: tQueryWord),
      );

  setUp(() {
    mockGetWordCard = MockGetWordCard();
    mockInputConverter = MockInputConverter();
    bloc = WordCardBloc(
      getWordCard: mockGetWordCard,
      converter: mockInputConverter,
    );
  });

  test('Inital state should be [Empty]', () {
    expect(bloc.state, equals(EmptyWordCardState()));
  });

  test(
    'should call InputConverter to validate and convert input string',
    () async {
      setupValidInputConversion();
      bloc.add(GetWordCardEvent(queryWord: tQueryWord));
      await untilCalled(mockInputConverter.convertToLower(any));
      verify(mockInputConverter.convertToLower(tQueryWord));
    },
  );

  blocTest(
    'should emit [Empty, ErrorState] when input is invalid',
    build: () {
      when(mockInputConverter.convertToLower(any))
          .thenReturn(Left(InvalidInputFailure()));
      return WordCardBloc(
        converter: mockInputConverter,
        getWordCard: mockGetWordCard,
      );
    },
    act: setupBlocAct,
    expect: [EmptyWordCardState(), ErrorWordCardState(message: INVALID_INPUT_ERROR_MESSAGE)],
  );

  test('should call GetWordDefinition usecase to get word entry data',
      () async {
    setupValidInputConversion();
    setupValidResponse();
    bloc.add(GetWordCardEvent(queryWord: tQueryWord));
    await untilCalled(mockGetWordCard(any));
    verify(mockGetWordCard(Param(queryWord: tQueryWordLower)));
  });

  blocTest(
    'should emit [Empty, Loading, Loaded] when input is valid',
    build: () {
      setupValidInputConversion();
      setupValidResponse();
      return WordCardBloc(
        converter: mockInputConverter,
        getWordCard: mockGetWordCard,
      );
    },
    act: setupBlocAct,
    expect: [
      EmptyWordCardState(),
      LoadingWordCardState(),
      LoadedWordCardState(wordCard: tWordCard),
    ],
  );

  void testBlocError(Failure failure, String message) {
    blocTest(
      'should emit [Empty, Loading, Error($message)] when data fetching fails',
      build: () {
        setupValidInputConversion();
        when(mockGetWordCard(any)).thenAnswer(
          (_) async => Left(failure),
        );
        return WordCardBloc(
          converter: mockInputConverter,
          getWordCard: mockGetWordCard,
        );
      },
      act: setupBlocAct,
      expect: [EmptyWordCardState(), LoadingWordCardState(), ErrorWordCardState(message: message)],
    );
  }

  testBlocError(DeviceOfflineFailure(), DEVICE_OFFLINE_ERROR_MESSAGE);
  testBlocError(NotFoundFailure(), NOT_FOUND_ERROR_MESSAGE);
  testBlocError(InvalidFilterFailure(), INVALID_FILTER_ERROR_MESSAGE);
  testBlocError(UnauthorizedFailure(), UNAUTHORIZED_ERROR_MESSAGE);
  testBlocError(ServerFailure(), SERVER_FAILURE_ERROR_MESSAGE);
  testBlocError(UnknownFailure(), UNKNOWN_ERROR_MESSAGE);
}

WordCard _buildWordCard() {
  return WordCard(
    word: "race",
    detailList: [
      WordCardDetails(
        definition: "compete in a race",
        partOfSpeech: "verb",
        synonymList: ["run"],
        exampleList: ["let's race and see who gets there first"],
      ),
      WordCardDetails(
        definition:
            "the flow of air that is driven backwards by an aircraft propeller",
        partOfSpeech: "noun",
        synonymList: ["airstream", "backwash", "slipstream", "wash"],
      ),
      WordCardDetails(
        definition: "cause to move fast or to rush or race",
        partOfSpeech: "verb",
        synonymList: ["rush"],
        exampleList: ["The psychologist raced the rats through a long maze"],
      ),
      WordCardDetails(
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
        exampleList: ["The cars raced down the street"],
      ),
      WordCardDetails(
        definition: "a canal for a current of water",
        partOfSpeech: "noun",
        synonymList: ["raceway"],
      ),
      WordCardDetails(
        definition:
            "(biology) a taxonomic group that is a division of a species; usually arises as a consequence of geographical isolation within a species",
        partOfSpeech: "noun",
        synonymList: ["subspecies"],
      ),
      WordCardDetails(
        definition: "a contest of speed",
        partOfSpeech: "noun",
        exampleList: ["the race is to the swift"],
      ),
      WordCardDetails(
        definition: "any competition",
        partOfSpeech: "noun",
        exampleList: ["the race for the presidency"],
      ),
      WordCardDetails(
        definition:
            "people who are believed to belong to the same genetic stock",
        partOfSpeech: "noun",
        exampleList: [
          "some biologists doubt that there are important genetic differences between races of human beings"
        ],
      ),
      WordCardDetails(
        definition:
            "to work as fast as possible towards a goal, sometimes in competition with others",
        partOfSpeech: "verb",
      ),
    ],
    syllables: Syllable(count: 1, list: ["race"]),
    pronunciation: Pronunciation(all: "res"),
  );
}
