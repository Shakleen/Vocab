import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vocab/features/query_word/data/models/retrieve_entry_model.dart';
import 'package:vocab/features/query_word/domain/repository/query_word_repository.dart';
import 'package:vocab/features/query_word/domain/usecases/get_word_definition.dart';

import '../../fixtures/fixture_reader.dart';

class MockQueryWordRepository extends Mock implements QueryWordRepository {}

void main() {
  MockQueryWordRepository mockQueryWordRepository;
  GetWordDefinition usecase;

  setUp(() {
    mockQueryWordRepository = MockQueryWordRepository();
    usecase = GetWordDefinition(repository: mockQueryWordRepository);
  });

  test('should get RetrieveEntry from QueryWordRepository', () async {
    final String tQueryWord = "test";
    final RetrieveEntryModel tEntry = RetrieveEntryModel.fromJson(
      json.decode(fixture('retrieve_entry_fixture.json')),
    );

    when(mockQueryWordRepository.getWordEntry(tQueryWord)).thenAnswer(
      (_) async => Right(tEntry),
    );

    final result = await usecase(Param(queryWord: tQueryWord));
    expect(result, Right(tEntry));
    verify(mockQueryWordRepository.getWordEntry(tQueryWord));
    verifyNoMoreInteractions(mockQueryWordRepository);
  });
}
