import 'package:flutterdemonstration/controllers/schedule.dart';
import 'package:flutterdemonstration/data/model/medicines.dart';
import 'package:intl/intl.dart';
import 'constants.dart';

class Utils {
  static String dateFormatterWithString(String date) {
    DateTime tempDate =
        DateFormat(AppDateFormat().apiDateFormatter).parse(date);
    String formattedDate =
        DateFormat(AppDateFormat().appDateFormatter).format(tempDate);
    return formattedDate;
  }

  static DateTime dateFormatterWithDate(String date) {
    DateTime tempDate =
        DateFormat(AppDateFormat().apiDateFormatter).parse(date);
    return tempDate;
  }

  static List<Medicines> filterByDateRange(List<MainScheduler> list) {
    List<Medicines> medicineList = [];
    DateTime suggestedStartDate = DateFormat(AppDateFormat().apiDateFormatter)
        .parse('2021-01-07 19:00:00');
    DateTime suggestedEndDate = DateFormat(AppDateFormat().apiDateFormatter)
        .parse('2021-01-14 19:00:00');

    for (MainScheduler arg in list) {
      if (suggestedStartDate
              .isBefore(Utils.dateFormatterWithDate(arg.scheduler.date)) &&
          suggestedEndDate
              .isAfter(Utils.dateFormatterWithDate(arg.scheduler.date))) {
        medicineList.addAll(arg.scheduler.medicines);
      }
    }
    return medicineList;
  }
}
