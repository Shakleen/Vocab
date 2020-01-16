import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Downloader {
  static final http.Client client = http.Client();

  static Future<Uri> downloadFile(String fileName, String url) async {
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;
    final File tempFile = File('$tempPath/$fileName');

    final http.Response response = await http.get(url);
    await tempFile.writeAsBytes(response.bodyBytes, flush: true);

    return tempFile.uri;
  }
}
