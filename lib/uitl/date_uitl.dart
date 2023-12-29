import 'package:intl/intl.dart';

class DateUtil {

  /// convert String To Date function
  /// [date] String we want to convert
  static DateTime convertStringToDate(String date) {
    const start = "/Date(";
    const end = "+0300)";
    final startIndex = date.indexOf(start);
    final endIndex = date.indexOf(end, startIndex + start.length);
    return DateTime.fromMillisecondsSinceEpoch(
      int.parse(
        date.substring(startIndex + start.length, endIndex),
      ),
    );
  }

  /// check Date
  /// [dateString] String we want to convert
  static String checkDate(DateTime checkedTime) {
    DateTime currentTime = DateTime.now();
    if ((currentTime.year == checkedTime.year) &&
        (currentTime.month == checkedTime.month) &&
        (currentTime.day == checkedTime.day)) {
      return "Today";
    } else if ((currentTime.year == checkedTime.year) &&
        (currentTime.month == checkedTime.month)) {
      if ((currentTime.day - checkedTime.day) == 1) {
        return "YESTERDAY";
      } else if ((currentTime.day - checkedTime.day) == -1) {
        return "Tomorrow";
      }

      if ((currentTime.day - checkedTime.day) <= -2) {
        return "Next Week";
      } else {
        return "Old Date";
      }
    }
    return "Old Date";
  }

  /// get month by
  /// [month] convert month number in to month name
  static getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
  }

  /// get month by
  /// [weekDay] convert week day in int to week day name
  static getWeekDay(int weekDay) {
    switch (weekDay) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday ";
      case 7:
        return "Sunday";
    }
  }


  /// get data formatted like Apr 26,2020
  /// [dateTime] convert DateTime to data formatted
  static String getMonthDayYearDateFormatted(DateTime dateTime) {
    if (dateTime != null)
      return getMonth(dateTime.month) +
          " " +
          dateTime.day.toString() +
          "," +
          dateTime.year.toString();
    else
      return "";
  }


  /// get data  formatted like 26/4/2020
  /// [dateTime] convert DateTime to data formatted
  static String getDayMonthYearDateFormatted(DateTime dateTime) {
    print(dateTime);
    if (dateTime != null)
      return dateTime.day.toString() +
          "/" +
          dateTime.month.toString() +
          "/" +
          dateTime.year.toString();
    else
      return "";
  }

  /// get data  formatted like 2020-05-26
  /// [dateTime] convert DateTime to data formatted
  static String convertDateToFormat(DateTime dateTime, String dateFormat) {
    return DateFormat(dateFormat).format(dateTime);
  }
}
