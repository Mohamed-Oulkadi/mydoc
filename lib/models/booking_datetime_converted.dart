import 'package:intl/intl.dart';

//this basically is to convert date/day/time from calendar to string
class DateConverted {
  static String getDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String getDay(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Sunday';
    }
  }

  static String getTime(int time) {
    switch (time) {
      case 0:
        return '09:00:00';
      case 1:
        return '10:00:00';
      case 2:
        return '11:00:00';
      case 3:
        return '12:00:00';
      case 4:
        return '13:00:00';
      case 5:
        return '14:00:00';
      case 6:
        return '15:00:00';
      case 7:
        return '16:00:00';
      default:
        return '9:00:00';
    }
  }
}
