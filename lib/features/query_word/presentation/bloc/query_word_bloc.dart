import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/util/input_converter.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';
import 'package:vocab/features/query_word/domain/usecases/get_word_definition.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

const String INVALID_INPUT_MESSAGE = "Invalid input detected!";

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
          yield Error(message: INVALID_INPUT_MESSAGE);
        },
        (String queryWordLower) async* {
          yield Loading();
          final fetchEither = await retriever(
            Param(queryWord: queryWordLower),
          );
          yield* fetchEither.fold(
            (failure) {},
            (RetrieveEntry wordEntry) async* {
              yield Loaded(retrieveEntry: wordEntry);
            },
          );
        },
      );
    }
  }
}
