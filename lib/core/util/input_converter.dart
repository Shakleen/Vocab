import 'package:dartz/dartz.dart';
import 'package:vocab/core/error/failures.dart';

class InputConverter {
  Either<InvalidInputFailure, String> convertToLower(String inputString) {
    if (RegExp(r'\d').hasMatch(inputString)) {
      return Left(InvalidInputFailure());
    } else {
      return Right(inputString.toLowerCase());
    }
  }
}
