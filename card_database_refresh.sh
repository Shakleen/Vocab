rm lib/core/database/card_database.g.dart
flutter clean
flutter packages get
flutter packages upgrade
flutter packages pub run build_runner watch --delete-conflicting-outputs