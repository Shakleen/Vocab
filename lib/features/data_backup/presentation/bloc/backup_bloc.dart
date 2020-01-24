import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class BackupBloc extends Bloc<BackupEvent, BackupState> {
  @override
  BackupState get initialState => InitialBackupState();

  @override
  Stream<BackupState> mapEventToState(
    BackupEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
