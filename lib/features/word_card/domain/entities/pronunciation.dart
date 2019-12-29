import 'package:equatable/equatable.dart';

enum PronunciationKeyNames { all }

class Pronunciation extends Equatable {
  final String all;

  const Pronunciation({this.all});

  @override
  List<Object> get props => [all];

  String getKeyString(PronunciationKeyNames name) =>
      name.toString().split('.').last;
}
