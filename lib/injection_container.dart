import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:vocab/core/network/network_info.dart';
import 'package:vocab/core/util/input_converter.dart';
import 'package:vocab/features/query_word/data/data_source/word_entry_data_source.dart';
import 'package:vocab/features/query_word/data/repository/query_word_repository_impl.dart';
import 'package:vocab/features/query_word/domain/repository/query_word_repository.dart';
import 'package:vocab/features/query_word/domain/usecases/get_word_definition.dart';
import 'package:vocab/features/query_word/presentation/bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:vocab/features/word_card/data/data_source/remote_dictionary.dart';
import 'package:vocab/features/word_card/data/repository/word_card_repository_impl.dart';
import 'package:vocab/features/word_card/domain/repository/word_card_repository.dart';
import 'package:vocab/features/word_card/domain/usecase/get_word_card.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature: Query Word
  //? Presentation layer
  // Bloc
  sl.registerFactory(
    () => QueryWordBloc(inputConverter: sl(), retriever: sl()),
  );

  //? Domain Layer
  // Use cases
  sl.registerLazySingleton(
    () => GetWordDefinition(repository: sl()),
  );

  //? Data layer
  // Repository
  sl.registerLazySingleton<QueryWordRepository>(
    () => QueryWordRepositoryImpl(networkChecker: sl(), source: sl()),
  );

  // Data source
  sl.registerLazySingleton<WordEntryDataSource>(
    () => OxfordWordEntryDataSource(client: sl()),
  );

  //!Feature: Word card
  //? Presentation later
  // Bloc
  sl.registerFactory(
    () => WordCardBloc(converter: sl(), getWordCard: sl()),
  );

  //? Domain layer
  // Use cases
  sl.registerLazySingleton(() => GetWordCard(repository: sl()));

  //? Data layer
  // Repository
  sl.registerLazySingleton<WordCardRepository>(
    () => WordCardRepositoryImpl(networkInfo: sl(), remoteDictionary: sl()),
  );

  // Data source
  sl.registerLazySingleton<RemoteDictionary>(
    () => WordsAPIRemoteDictionary(client: sl()),
  );

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
