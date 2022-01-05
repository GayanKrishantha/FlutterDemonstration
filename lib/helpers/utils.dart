import 'package:intl/intl.dart';
import 'constants.dart';

class Utils {
  static String dateFormatterWithString(String date) {
    DateTime tempDate = DateFormat(AppDateFormat().apiDateFormatter).parse(date);
    String formattedDate = DateFormat(AppDateFormat().appDateFormatter).format(tempDate);
    return formattedDate;
  }

  static DateTime dateFormatterWithDate(String date) {
    DateTime tempDate =
        DateFormat(AppDateFormat().apiDateFormatter).parse(date);
    return tempDate;
  }
}
