import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/word_card/data/models/word_details_model.dart';
import 'package:vocab/features/word_card/domain/entities/word_details.dart';

import '../../../../fixture_reader.dart';

void main() {
  final String fixturePath =
      'test/features/word_card/fixtures/word_details.json';
  WordDetailsModel tWordDetailsModel;

  setUp(() {
    tWordDetailsModel = _buildModel();
  });

  test('should be of type WordDetails', () {
    expect(tWordDetailsModel, isA<WordDetails>());
  });

  test('should return WordDetailsModel object after fromJson', () {
    final result = WordDetailsModel.fromJson(
      json.decode(fixture(fixturePath)),
    );
    expect(result, equals(tWordDetailsModel));
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tWordDetailsModel.toJson();
    expect(jsonData, json.decode(fixture(fixturePath)));
  });
}

WordDetailsModel _buildModel() {
  return WordDetailsModel(
    definition: "compete in a race",
    partOfSpeech: "verb",
    synonymList: ["run"],
    typeOfList: ["compete", "vie", "contend"],
    hasTypeList: [
      "horse-race",
      "boat-race",
      "campaign",
      "place",
      "run",
      "show",
      "speed skate"
    ],
    derivationList: ["racer", "racing"],
    exampleList: ["let's race and see who gets there first"],
  );
}
