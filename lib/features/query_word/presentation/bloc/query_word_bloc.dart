import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:vocab/core/error/error_messages.dart';
import 'package:vocab/core/error/failures.dart';
import 'package:vocab/core/util/input_converter.dart';
import 'package:vocab/features/query_word/domain/entities/retrieve_entry.dart';
import 'package:vocab/features/query_word/domain/usecases/get_word_definition.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

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
    yield Error(message: getErrorMessage(failure));
  }

  Stream<QueryWordState> _successfulFetchCase(RetrieveEntry wordEntry) async* {
    yield Loaded(retrieveEntry: wordEntry);
  }
}
