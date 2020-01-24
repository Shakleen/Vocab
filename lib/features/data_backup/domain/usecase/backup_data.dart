import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class BackupData extends UseCase<bool, NoParams> {
  final BackUpDataRepository repository;

  BackupData({@required this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    // TODO: Implement function
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}