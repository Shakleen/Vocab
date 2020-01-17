import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class PerformaceResult extends Equatable {
  final int totalCorrect;
  final int totalWrong;

  PerformaceResult({
    @required this.totalCorrect,
    @required this.totalWrong,
  });

  @override
  List<Object> get props => [totalCorrect, totalWrong];
}
