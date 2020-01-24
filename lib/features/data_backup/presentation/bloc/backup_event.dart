import 'package:equatable/equatable.dart';

abstract class BackupEvent extends Equatable {
  const BackupEvent();
}

class InitiateBackup extends BackupEvent {
  @override
  List<Object> get props => [];
}

class ViewBackups extends BackupEvent {
  @override
  List<Object> get props => [];
}

class ViewBackupFile extends BackupEvent {
  @override
  List<Object> get props => [];
}

class InitiateSync extends BackupEvent {
  @override
  List<Object> get props => [];
}
