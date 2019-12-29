import 'package:equatable/equatable.dart';

enum SyllableKeyNames { count, list }

class Syllable extends Equatable {
  final int count;
  final List<String> list;

  const Syllable({this.count, this.list});

  @override
  List<Object> get props => [count, list];

  String getKeyString(SyllableKeyNames name) => name.toString().split('.').last;
}
