import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/word_card/data/models/pronunciation_model.dart';
import 'package:vocab/core/entities/pronunciation.dart';

import '../../../../fixture_reader.dart';

void main() {
  final String fixturePath =
      'test/features/word_card/fixtures/pronunciation.json';
  PronunciationModel tPronunciationModel;

  setUp(() {
    tPronunciationModel = _buildModel();
  });

  test('should be of type Pronunciation', () {
    expect(tPronunciationModel, isA<Pronunciation>());
  });

  test('should return PronunciationModel object after fromJson', () {
    final result = PronunciationModel.fromJson(
      json.decode(fixture(fixturePath)),
    );
    expect(result, equals(tPronunciationModel));
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tPronunciationModel.toJson();
    expect(jsonData, json.decode(fixture(fixturePath)));
  });
}

PronunciationModel _buildModel() {
  return PronunciationModel(all: 'test all');
}
