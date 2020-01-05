import 'package:flutter/material.dart';
import 'package:vocab/core/entities/word_card.dart';

class FormValuesInheritedWidget extends InheritedWidget {
  final WordCard wordCard;

  FormValuesInheritedWidget({
    Key key,
    @required this.wordCard,
    @required Widget child,
  }) : super(key: key, child: child);

  static FormValuesInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType() as FormValuesInheritedWidget;

  @override
  bool updateShouldNotify(FormValuesInheritedWidget old) => wordCard != old.wordCard;
}
