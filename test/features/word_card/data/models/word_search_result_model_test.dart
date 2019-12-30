import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/features/word_card/data/models/pronunciation_model.dart';
import 'package:vocab/features/word_card/data/models/syllable_model.dart';
import 'package:vocab/features/word_card/data/models/word_details_model.dart';
import 'package:vocab/features/word_card/data/models/word_search_result_model.dart';
import 'package:vocab/features/word_card/domain/entities/word_search_result.dart';

import '../../../../fixture_reader.dart';

void main() {
  final String fixturePath =
      'test/features/word_card/fixtures/word_search_result.json';
  WordSearchResultModel tWordSearchResultModel;

  setUp(() {
    tWordSearchResultModel = _buildModel();
  });

  test('should be of type WordSearchResult', () {
    expect(tWordSearchResultModel, isA<WordSearchResult>());
  });

  test('should return WordSearchResult object after fromJson', () {
    final result = WordSearchResultModel.fromJson(
      json.decode(fixture(fixturePath)),
    );
    expect(result, equals(tWordSearchResultModel));
  });

  test('should return json object after toJson', () {
    final Map<String, dynamic> jsonData = tWordSearchResultModel.toJson();
    expect(jsonData, json.decode(fixture(fixturePath)));
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
            ]
        ),
        WordDetailsModel(
            definition: "the flow of air that is driven backwards by an aircraft propeller",
            partOfSpeech: "noun",
            synonymList: [
                "airstream",
                "backwash",
                "slipstream",
                "wash"
            ],
            typeOfList: [
                "flow"
            ]
        ),
        WordDetailsModel(
            definition: "cause to move fast or to rush or race",
            partOfSpeech: "verb",
            synonymList: [
                "rush"
            ],
            typeOfList: [
                "move",
                "displace"
            ],
            derivationList: [
                "racer"
            ],
            exampleList: [
                "The psychologist raced the rats through a long maze"
            ]
        ),
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
            ]
        ),
        WordDetailsModel(
            definition: "a canal for a current of water",
            partOfSpeech: "noun",
            synonymList: [
                "raceway"
            ],
            typeOfList: [
                "canal"
            ]
        ),
        WordDetailsModel(
            definition: "(biology) a taxonomic group that is a division of a species; usually arises as a consequence of geographical isolation within a species",
            partOfSpeech: "noun",
            synonymList: [
                "subspecies"
            ],
            inCategoryList: [
                "biological science",
                "biology"
            ],
            typeOfList: [
                "taxonomic group",
                "taxon",
                "taxonomic category"
            ]
        ),
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
            ]
        ),
        WordDetailsModel(
            definition: "any competition",
            partOfSpeech: "noun",
            typeOfList: [
                "competition",
                "contest"
            ],
            hasTypeList: [
                "campaign",
                "political campaign",
                "run",
                "arms race"
            ],
            exampleList: [
                "the race for the presidency"
            ]
        ),
        WordDetailsModel(
            definition: "people who are believed to belong to the same genetic stock",
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
            ]
        ),
        WordDetailsModel(
            definition: "to work as fast as possible towards a goal, sometimes in competition with others",
            partOfSpeech: "verb",
            typeOfList: [
                "move",
                "act"
            ]
        ),
    ],
  );
}
