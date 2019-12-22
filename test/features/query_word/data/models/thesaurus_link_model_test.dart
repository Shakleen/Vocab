import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/query_word/data/models/thesaurus_link_model.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final ThesaurusLinkModel tThesaurusLinkModel = ThesaurusLinkModel(
    entryId: "test entry id",
    senseId: "test sense id",
  );
  final String fixtureFileName = 'thesaurus_link_fixture.json';

  test('should be of type ThesaurusLinkModel', () {
    expect(tThesaurusLinkModel, isA<ThesaurusLinkModel>());
  });

  test('should return ThesaurusLinkModel object after fromJson', () {
    final Map<String, dynamic> jsonData = json.decode(
      fixture(fixtureFileName),
    );
    expect(ThesaurusLinkModel.fromJson(jsonData), tThesaurusLinkModel);
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tThesaurusLinkModel.toJson();
    expect(jsonData, json.decode(fixture(fixtureFileName)));
  });
}
