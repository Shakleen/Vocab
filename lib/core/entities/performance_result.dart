import 'package:equatable/equatable.dart';

class PerformaceResult extends Equatable {
  final int totalCorrect;
  final int totalWrong;

  PerformaceResult({this.totalCorrect = 0, this.totalWrong = 0});

  @override
  List<Object> get props => [totalCorrect, totalWrong];
}

class Performance extends Equatable {
  final Map<DateTime, PerformaceResult> performanceMap;
  final int maxValue, minValue;

  Performance({this.performanceMap, this.maxValue, this.minValue});

  @override
  List<Object> get props => [performanceMap, maxValue, minValue];
}
