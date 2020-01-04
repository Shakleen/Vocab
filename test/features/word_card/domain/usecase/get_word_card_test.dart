import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/features/word_card/data/models/word_search_result_model.dart';
import 'package:vocab/features/word_card/domain/entities/word_search_result.dart';
import 'package:vocab/features/word_card/domain/repository/word_card_repository.dart';
import 'package:vocab/features/word_card/domain/usecase/get_word_card.dart';

import '../../../../fixture_reader.dart';

class MockWordCardRepository extends Mock implements WordCardRepository {}

void main() {
  final String tQueryWord = "race";
  final String fixturePath =
      'test/features/word_card/fixtures/word_search_result.json';
  final WordSearchResult tWordSearchResult = WordSearchResultModel.fromJson(
    json.decode(fixture(fixturePath)),
  );
  MockWordCardRepository mockWordCardRepository;
  GetWordCard usecase;

  setUp(() {
    mockWordCardRepository = MockWordCardRepository();
    usecase = GetWordCard(repository: mockWordCardRepository);
  });

  void setupMockRepositoryForSuccess() {
    when(mockWordCardRepository.getWordInformation(any)).thenAnswer(
      (_) async => Right(tWordSearchResult),
    );
  }

  test('should request WordCardRepository for getting word information',
      () async {
    setupMockRepositoryForSuccess();
    await usecase(Param(queryWord: tQueryWord));
    verify(mockWordCardRepository.getWordInformation(tQueryWord));
    verifyNoMoreInteractions(mockWordCardRepository);
  });

  test('should return WordCard object when successful', () async {
    setupMockRepositoryForSuccess();
    final result = await usecase(Param(queryWord: tQueryWord));
    expect(result, isA<Either<Failure, WordCard>>());
  });

  test('should return Failure object when unsuccessful', () async {
    when(mockWordCardRepository.getWordInformation(any)).thenAnswer(
      (_) async => Left(UnknownFailure()),
    );
    final result = await usecase(Param(queryWord: tQueryWord));
    expect(result, equals(Left(UnknownFailure())));
  });
}

