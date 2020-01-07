import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card.dart';
import 'package:vocab/core/ui/pages/base_page.dart';
import 'package:vocab/core/ui/pages/error_route_page.dart';
import 'package:vocab/features/word_card_save/presentation/pages/card_form_page.dart';
import 'package:vocab/features/word_card_save/presentation/pages/card_page.dart';
import 'package:vocab/features/word_card_save/presentation/pages/show_word_info_page.dart';

enum Page { HomePage, CardPage, CardFormPage, ShowWordInfoPage }

Route generateRoute(RouteSettings settings) {
  if (settings.name == '${Page.HomePage}') {
    return MaterialPageRoute(
      builder: (BuildContext context) => BasePage(),
    );
  } else if (settings.name == '${Page.CardPage}') {
    return MaterialPageRoute(
      builder: (BuildContext context) => CardPage(),
    );
  } else if (settings.name == '${Page.CardFormPage}') {
    final WordCard wordCard = _getWordCard(settings);

    return MaterialPageRoute(
      builder: (BuildContext context) => CardFormPage(
        initialWordCard: wordCard,
      ),
    );
  } else if (settings.name == '${Page.ShowWordInfoPage}') {
    final String word = settings.arguments;

    return MaterialPageRoute(
      builder: (BuildContext context) => ShowWordInfoPage(word: word),
    );
  }

  return MaterialPageRoute(
    builder: (BuildContext context) => ErrorRoutePage(),
  );
}

WordCard _getWordCard(RouteSettings settings) {
  return settings.arguments is WordCard ? settings.arguments : null;
}
