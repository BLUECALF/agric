import 'package:intl/intl.dart';

String getDateString(DateTime now) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}

String getFormattedTime(DateTime now)
{
  String formattedTime = DateFormat. Hms(). format(now);
  return formattedTime;
}

