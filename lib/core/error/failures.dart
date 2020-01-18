import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  Failure({this.properties = const <dynamic>[]});
  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure {}

class NotFoundFailure extends Failure {}

class InvalidFilterFailure extends Failure {}

class TooLongURLFailure extends Failure {}

class CacheFailure extends Failure {}

class UnknownFailure extends Failure {}

class DeviceOfflineFailure extends Failure {}

class InvalidInputFailure extends Failure {}

class UnauthorizedFailure extends Failure {}

class DatabaseFailure extends Failure {}

class EmptyListFailure extends Failure {}
