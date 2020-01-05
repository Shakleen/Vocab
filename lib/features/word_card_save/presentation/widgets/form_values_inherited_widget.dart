import 'package:flutter/material.dart';

class FormValuesInheritedWidget extends InheritedWidget {
  final Map<String, dynamic> formValues;

  FormValuesInheritedWidget({
    Key key,
    @required this.formValues,
    @required Widget child,
  }) : super(key: key, child: child);

  static FormValuesInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType() as FormValuesInheritedWidget;

  @override
  bool updateShouldNotify(FormValuesInheritedWidget old) => formValues != old.formValues;
}
