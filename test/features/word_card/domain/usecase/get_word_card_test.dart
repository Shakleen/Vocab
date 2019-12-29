import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vocab/features/word_card/domain/repository/word_card_repository.dart';
import 'package:vocab/features/word_card/domain/usecase/get_word_card.dart';

class MockWordCardRepository extends Mock implements WordCardRepository {}

void main() {
  MockWordCardRepository mockWordCardRepository;
  GetWordCard usecase;

  setUp(() {
    mockWordCardRepository = MockWordCardRepository();
    usecase = GetWordCard(repository: mockWordCardRepository);
  });

  test('should request WordCardRepository for getting word information', () {
    when(mockWordCardRepository.getWordInformation(any)).thenAnswer(answer)
  });
}