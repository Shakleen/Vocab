import 'dart:io';

String fixture(String path) => File('test/features/query_word/fixtures/$path').readAsStringSync();
