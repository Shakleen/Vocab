import 'package:intl/intl.dart';

String getFormattedDateTime(DateTime dateTime) {
  final DateFormat dateFormat = DateFormat.MMMMEEEEd();
  return dateFormat.format(dateTime);
}