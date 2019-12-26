import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/util/input_converter.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';
import 'package:vocab/features/query_word/domain/usecases/get_word_definition.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

const String INVALID_INPUT_ERROR_MESSAGE = "Invalid input detected!";
const String DEVICE_OFFLINE_ERROR_MESSAGE = "No internet detected!";
const String UNKNOWN_ERROR_MESSAGE = "Unknown error!";
const String NOT_FOUND_ERROR_MESSAGE = "Word entry not found!";
const String INVALID_FILTER_ERROR_MESSAGE = "Invalid filter used!";
const String TOO_LONG_URL_ERROR_MESSAGE = "The URL is too long!";
const String SERVER_FAILURE_ERROR_MESSAGE = "Server failure has occured!";

class QueryWordBloc extends Bloc<QueryWordEvent, QueryWordState> {
  final GetWordDefinition retriever;
  final InputConverter inputConverter;

  QueryWordBloc({
    @required this.retriever,
    @required this.inputConverter,
  });

  @override
  QueryWordState get initialState => Empty();

  @override
  Stream<QueryWordState> mapEventToState(QueryWordEvent event) async* {
    if (event is GetWordEntryEvent) {
      final inputEither = inputConverter.convertToLower(event.queryWord);
      yield* inputEither.fold(_invalidInputCase, _validInputCase);
    }
  }

  Stream<QueryWordState> _invalidInputCase(InvalidInputFailure failure) async* {
    yield Error(message: INVALID_INPUT_ERROR_MESSAGE);
  }

  Stream<QueryWordState> _validInputCase(String queryWordLower) async* {
    yield Loading();
    final fetchEither = await retriever(Param(queryWord: queryWordLower));
    yield* fetchEither.fold(_errorOccuredCase, _successfulFetchCase);
  }

  Stream<QueryWordState> _errorOccuredCase(Failure failure) async* {
    yield Error(message: _getErrorMessage(failure));
  }

  Stream<QueryWordState> _successfulFetchCase(RetrieveEntry wordEntry) async* {
    yield Loaded(retrieveEntry: wordEntry);
  }

  String _getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DeviceOfflineFailure:
        return DEVICE_OFFLINE_ERROR_MESSAGE;
      case NotFoundFailure:
        return NOT_FOUND_ERROR_MESSAGE;
      case InvalidFilterFailure:
        return INVALID_FILTER_ERROR_MESSAGE;
      case TooLongURLFailure:
        return TOO_LONG_URL_ERROR_MESSAGE;
      case ServerFailure:
        return SERVER_FAILURE_ERROR_MESSAGE;
      default:
        return UNKNOWN_ERROR_MESSAGE;
    }
  }
}
