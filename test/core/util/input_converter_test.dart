import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/util/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  test('should return a string where all letters are lower case', () {
    final String tString = "ThIs Is a MiX oF cAsEs";
    final expected = Right("this is a mix of cases");
    expect(
      inputConverter.convertToLower(tString),
      expected,
    );
  });

  test('should throw InvalidInputFailure when numbers are found', () {
    final String tString = "Th1s shou1d thr0w an 4rror!";
    final expected = Left(InvalidInputFailure());
    expect(inputConverter.convertToLower(tString), expected);
  });
}
