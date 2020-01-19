import 'package:intl/intl.dart';

String getFormattedDateTime(DateTime dateTime) {
  final DateFormat dateFormat = DateFormat.MMMMEEEEd();
  return dateFormat.format(dateTime);
}

String getShortFormattedDateTIme(DateTime dateTime) {
  final DateFormat dateFormat = DateFormat.MMMd();
  return dateFormat.format(dateTime);
}