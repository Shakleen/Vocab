# ================================================================================================
# Data Layer
# ================================================================================================
# Model json parsing tests
flutter test test/features/query_word/data/models/base_info_model_test.dart
flutter test test/features/query_word/data/models/pronunciation_model_test.dart
flutter test test/features/query_word/data/models/thesaurus_link_model_test.dart
flutter test test/features/query_word/data/models/related_entry_model_test.dart
flutter test test/features/query_word/data/models/construction_model_test.dart
flutter test test/features/query_word/data/models/variant_form_model_test.dart
flutter test test/features/query_word/data/models/example_model_test.dart
flutter test test/features/query_word/data/models/sense_model_test.dart
flutter test test/features/query_word/data/models/entry_model_test.dart
flutter test test/features/query_word/data/models/lexical_model_test.dart
flutter test test/features/query_word/data/models/headword_entry_model_test.dart
flutter test test/features/query_word/data/models/retrieve_entry_model_test.dart

# Data source tests
flutter test test/features/query_word/data/data_source/word_entry_data_source_test.dart

# Repository tests
flutter test test/features/query_word/data/repository/query_word_repository_impl_test.dart

# ================================================================================================
# Domain Layer
# ================================================================================================
# Usecase test
flutter test test/features/query_word/domain/usecases/get_word_definition_test.dart