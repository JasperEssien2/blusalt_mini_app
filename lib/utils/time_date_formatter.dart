import 'package:intl/intl.dart';

///Contains all method related to date formatting
class TimeDateFormatter {
  ///This method parse a string date to a [DateTime] object,
  ///@Param [stringDate] the date in string format to parse, input format is [yyyy-MM-DDTHH:MM aa]
  ///@Param [returnWithAmOrPM] if this is true it parses considering the time of day
  static DateTime parseStringDate(String stringDate,
      {bool returnWithAmOrPM = true, bool is24Hours = true}) {
    var parsedDate = is24Hours
        ? DateFormat(
            returnWithAmOrPM ? "yyyy-MM-dd'T'HH:mm a" : "yyyy-MM-dd'T'HH:mm")
        : DateFormat(
            returnWithAmOrPM ? "yyyy-MM-dd'T'hh:mm a" : "yyyy-MM-dd'T'hh:mm");

    return parsedDate.parse(stringDate);
  }

  ///This method compares [dateToCompare] with a [startDate] and a [endDate]
  ///Returns [DateComparison.IN_BETWEEN] if [dateToCompare] is inbetween the other 2 dates
  ///[DateComparison.EQUALS_START] or [DateComparison.EQUALS_END] if equals to [startDate] or [endDate] respectively
  static DateComparison? compareDateToStartEndDateDate(
      {required DateTime startDate,
      required DateTime endDate,
      required DateTime dateToCompare}) {
    if (dateToCompare.isAtSameMomentAs(startDate))
      return DateComparison.EQUALS_START;
    else if (dateToCompare.isAtSameMomentAs(endDate))
      return DateComparison.EQUALS_END;
    else if (dateToCompare.isAfter(startDate) &&
        dateToCompare.isBefore(endDate))
      return DateComparison.IN_BETWEEN;
    else if (dateToCompare.isBefore(startDate))
      return DateComparison.BEFORE_START;
    // throw CustomException('Illegal State Exception');
    return null;
  }

  ///This returns a greeting to be used in [HomeScreen], greeting returned is based on time of the day
  static String getGreeting({required DateTime dateTime}) {
    var hour = dateTime.hour;

    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 16) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  static String getExperience(str) {
    var date = DateTime.tryParse(str);
    if (date != null) {
      var now = DateTime.now();
      var diff = (now.difference(date).inDays / 365).floor();
      if (diff > 1) {
        return diff.toString() + ' years';
      } else {
        return diff.toString() + ' year';
      }
    } else {
      return "No Experience";
    }
  }
}

enum DateComparison {
  IN_BETWEEN,
  AFTER_START,
  AFTER_END,
  BEFORE_START,
  BEFORE_END,
  EQUALS_START,
  EQUALS_END,
}
