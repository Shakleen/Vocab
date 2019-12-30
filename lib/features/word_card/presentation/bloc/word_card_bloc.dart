import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class WordCardBloc extends Bloc<WordCardEvent, WordCardState> {
  @override
  WordCardState get initialState => EmptyState();

  @override
  Stream<WordCardState> mapEventToState(
    WordCardEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
