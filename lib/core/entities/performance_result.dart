import 'package:equatable/equatable.dart';

class PerformaceResult extends Equatable {
  final int totalCorrect;
  final int totalWrong;

  PerformaceResult({this.totalCorrect = 0, this.totalWrong = 0});

  @override
  List<Object> get props => [totalCorrect, totalWrong];
}
