import 'dart:convert';

import 'package:vocab/core/error/exceptions.dart';
import 'package:vocab/features/query_word/data/models/retrieve_entry_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class WordEntryDataSource {
  String get appID;
  String get appKey;
  String get entryApiUrl;
  Future<RetrieveEntryModel> getWordEntry(String word);
}

class OxfordWordEntryDataSource implements WordEntryDataSource {
  final http.Client client;

  OxfordWordEntryDataSource({@required this.client});

  @override
  String get appID => '7c260150';

  @override
  String get appKey => 'a4d70cf55b6b949117c286b08736900e';

  @override
  String get entryApiUrl =>
      'https://od-api.oxforddictionaries.com:443/api/v2/entries/en-gb/';

  @override
  Future<RetrieveEntryModel> getWordEntry(String word) async {
    final http.Response response = await client.get(
      entryApiUrl + word + '?strictMatch=false',
      headers: {
        'Content-Type': 'application/json',
        'app_id': appID,
        'app_key': appKey,
      },
    );

    switch (response.statusCode) {
      case 200:
        return RetrieveEntryModel.fromJson(json.decode(response.body));
      case 404:
        throw NotFoundException();
      case 400:
        throw InvalidFilterException();
      case 414:
        throw TooLongURLException();
      case 500:
        throw ServerException();
      default:
        throw UnknownException();
    }
  }
}
