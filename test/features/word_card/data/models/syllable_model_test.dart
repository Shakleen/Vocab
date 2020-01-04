import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/word_card/data/models/syllable_model.dart';
import 'package:vocab/core/entities/syllable.dart';

import '../../../../fixture_reader.dart';

void main() {
  final String fixturePath = 'test/features/word_card/fixtures/syllable.json';
  SyllableModel tSyllableModel;

  setUp(() {
    tSyllableModel = _buildModel();
  });

  test('should be of type Syllable', () {
    expect(tSyllableModel, isA<Syllable>());
  });

  test('should return SyllableModel object after fromJson', () {
    final result = SyllableModel.fromJson(
      json.decode(fixture(fixturePath)),
    );
    expect(result, equals(tSyllableModel));
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tSyllableModel.toJson();
    expect(jsonData, json.decode(fixture(fixturePath)));
  });
}

SyllableModel _buildModel() {
  return SyllableModel(count: 1, list: ['race']);
}
