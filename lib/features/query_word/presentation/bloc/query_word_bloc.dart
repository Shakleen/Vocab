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
      yield* inputEither.fold(
        (InvalidInputFailure failure) async* {
          yield Error(message: INVALID_INPUT_ERROR_MESSAGE);
        },
        (String queryWordLower) async* {
          yield Loading();
          final fetchEither = await retriever(
            Param(queryWord: queryWordLower),
          );
          yield* fetchEither.fold(
            (Failure failure) async* {
              String errorMessage;
              
              switch(failure.runtimeType) {
                case DeviceOfflineFailure:
                  errorMessage = DEVICE_OFFLINE_ERROR_MESSAGE;
                  break;
                default:
                  errorMessage = UNKNOWN_ERROR_MESSAGE;
              }

              yield Error(message: errorMessage);
            },
            (RetrieveEntry wordEntry) async* {
              yield Loaded(retrieveEntry: wordEntry);
            },
          );
        },
      );
    }
  }
}