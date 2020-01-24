import 'package:equatable/equatable.dart';

abstract class BackupState extends Equatable {
  const BackupState();
}

class InitialBackupState extends BackupState {
  @override
  List<Object> get props => [];
}
