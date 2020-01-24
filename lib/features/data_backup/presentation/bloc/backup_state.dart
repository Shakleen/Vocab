import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class BackupState extends Equatable {
  const BackupState();
}

class ShowBackupFiles extends BackupState {
  final List<File> backupFiles;

  ShowBackupFiles(this.backupFiles);

  @override
  List<Object> get props => [backupFiles];
}

class ShowBackupProgress extends BackupState {
  @override
  List<Object> get props => [];
}

class ShowBackupFinished extends BackupState {
  @override
  List<Object> get props => [];
}

class ShowSyncedFiles extends BackupState {
  final List<File> syncedFiles;

  ShowSyncedFiles(this.syncedFiles);

  @override
  List<Object> get props => [syncedFiles];
}

class ShowSyncProgress extends BackupState {
  @override
  List<Object> get props => [];
}

class ShowSyncFinished extends BackupState {
  @override
  List<Object> get props => [];
}

class ShowFile extends BackupState {
  final String fileData;

  ShowFile(this.fileData);

  @override
  List<Object> get props => [];
}


