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
import 'package:vocab/features/quiz_card/data/repository/quiz_repository_impl.dart';
import 'package:vocab/features/quiz_card/domain/repository/quiz_repository.dart';
import 'package:vocab/features/quiz_card/domain/usecase/fetch_quiz_cards.dart';
import 'package:vocab/features/quiz_card/domain/usecase/mark_correct.dart';
import 'package:vocab/features/quiz_card/domain/usecase/mark_wrong.dart';
import 'package:vocab/features/quiz_card/presentation/bloc/quiz_bloc.dart';
import 'package:vocab/features/show_saved_words/data/repository/saved_words_repository_impl.dart';
import 'package:vocab/features/show_saved_words/domain/repository/saved_words_repository.dart';
import 'package:vocab/features/show_saved_words/domain/usecase/get_saved_words.dart';
import 'package:vocab/features/show_saved_words/presentation/bloc/word_list_bloc.dart';
import 'package:vocab/features/word_card/data/data_source/remote_dictionary.dart';
import 'package:vocab/features/word_card/data/repository/word_card_repository_impl.dart';
import 'package:vocab/features/word_card/domain/repository/word_card_repository.dart';
import 'package:vocab/features/word_card/domain/usecase/get_word_card.dart';
import 'package:vocab/features/word_card/presentation/bloc/bloc.dart';

import 'core/database/card_database.dart';
import 'features/word_save/data/repository/word_save_repository_impl.dart';
import 'features/word_save/domain/repository/word_save_repository.dart';
import 'features/word_save/domain/usecase/insert_word_details.dart';
import 'features/word_save/domain/usecase/update_word_details.dart';
import 'features/word_save/presentation/bloc/word_save_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Feature: Query Word
  //? Presentation layer
  // Bloc
  sl.registerFactory<QueryWordBloc>(
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
  sl.registerFactory<WordCardBloc>(
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

  //!Feature: Show saved words
  //? Presentation later
  // Bloc
  sl.registerFactory<WordListBloc>(() => WordListBloc(sl()));

  //? Domain
  // Use cases
  sl.registerLazySingleton<GetSavedWords>(
      () => GetSavedWords(repository: sl()));

  //? Data
  // Repository
  sl.registerLazySingleton<SavedWordsRepository>(
      () => SavedWordRepositoryImpl(sl()));

  //!Feature: Save words
  //? Presentation later
  // Bloc
  sl.registerFactory<WordSaveBloc>(
    () => WordSaveBloc(insertUsecase: sl(), updateUsecase: sl()),
  );

  //? Domain
  // Use cases
  sl.registerLazySingleton<InsertWordDetails>(
      () => InsertWordDetails(repository: sl()));
  sl.registerLazySingleton<UpdateWordDetails>(
      () => UpdateWordDetails(repository: sl()));

  //? Data
  // Repository
  sl.registerLazySingleton<WordSaveRepository>(
      () => WordSaveRepositoryImpl(sl()));

  //!Feature: Quiz on words
  //? Presentation later
  // Bloc
  sl.registerFactory<QuizBloc>(
    () => QuizBloc(
      fetchUseCase: sl(),
      markCorrectUsecase: sl(),
      markWrongUsecase: sl(),
    ),
  );

  //? Domain
  // Use cases
  sl.registerLazySingleton<FetchQuizCards>(
      () => FetchQuizCards(sl()));
  sl.registerLazySingleton<MarkCorrect>(
      () => MarkCorrect(sl()));
  sl.registerLazySingleton<MarkWrong>(
      () => MarkWrong(sl()));

  //? Data
  // Repository
  sl.registerLazySingleton<QuizRepository>(
      () => QuizRepositoyImpl(sl()));

  //! Core
  sl.registerLazySingleton(() => CardDatabase());
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
}
