import 'package:intl/intl.dart';

class FormatUtils {
  static String dateFormat(String date) {
    var dateString;
    var dateFormater = DateFormat('dd-MM-yyyy');

    if (date.isNotEmpty) {
      dateString = dateFormater.format(DateTime.parse(date));
      return dateString;
    }

    return '-';
  }

  static String differentDate(String date1, String date2) {
    String diffDate;

    if (date1.isNotEmpty && date2.isNotEmpty) {
      DateTime dt1 = DateTime.parse(date1);
      DateTime dt2 = DateTime.parse(date2);

      int days = dt1.difference(dt2).inDays;
      int hours = dt1.difference(dt2).inHours;

      if (days > 0) {
        diffDate = '${days.toString()} days';
      } else {
        diffDate = '${hours.toString()} hours';
      }
      return diffDate;
    }
  }
}