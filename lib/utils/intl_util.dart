import 'package:intl/intl.dart';

class IntlUtil {
  static String formatPhone(String tel) {
    if (tel.length == 10) {
      return "${tel.substring(0, 3)} ${tel.substring(3, 6)} ${tel.substring(6)}";
    } else if (tel.length == 11) {
      return "${tel.substring(0, 4)} ${tel.substring(4, 7)} ${tel.substring(7)}";
    } else {
      tel = tel.padRight(13, "*");
      return "+${tel.substring(0, 3)} ${tel.substring(3, 6)} ${tel.substring(6, 9)} ${tel.substring(9)}";
    }
  }

  static String formatDate(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat.yMd().format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat.yMd().format(DateTime.now());
    }
    return DateFormat.yMd().format(datetime);
  }

  static String formatDateShort(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('MMMM d, y').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('MMMM d, y').format(DateTime.now());
    }
    return DateFormat('MMMM d, y').format(datetime);
  }

  static String formatDateTime(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat('y/M/d H:mm:s').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('y/M/d H:mm:s').format(DateTime.now());
    }
    return DateFormat('y/M/d H:mm:s').format(datetime);
  }

  static String formatDateMedium(DateTime date, {bool displayTime = true}) {
    String timeFormat = displayTime ? 'H:mm:s' : '';

    if (date == null) {
      return DateFormat('d MMMM, y. $timeFormat').format(DateTime.now());
    }
    return DateFormat('d MMMM, y. $timeFormat').format(date);
  }

  static String formatTimeMedium(
    String date,
  ) {
    String timeFormat = 'H:mm:s';

    if (date == null || date.isEmpty) {
      return DateFormat('$timeFormat').format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat('$timeFormat').format(DateTime.now());
    }
    return DateFormat('$timeFormat').format(datetime);
  }

  static String formatDateLong(String date) {
    if (date == null || date.isEmpty) {
      return DateFormat.yMMMMEEEEd().format(DateTime.now());
    }
    final datetime = DateTime.tryParse(date);
    if (datetime == null) {
      return DateFormat.yMMMMEEEEd().format(DateTime.now());
    }
    return DateFormat.yMMMMEEEEd().format(datetime);
  }

  static String capitalise(String text) {
    if (text == null || text.length == 0) {
      return "";
    } else if (text.length == 1) {
      return text.toUpperCase();
    } else {
      final firstChar = text[0];
      return "${firstChar.toUpperCase()}${text.substring(1).toLowerCase()}";
    }
  }

  static String formatCurrencyInput(String amount) {
    final formatter = NumberFormat.currency(
      locale: "en_NG",
      name: 'NGN',
      symbol: "₦",
      decimalDigits: 2,
    );
    amount = amount.replaceAll(RegExp(r'[^0-9\.]'), "");
    final amountDouble = double.tryParse(amount);
    if (amount == null || amountDouble == null) {
      return "";
    }
    return formatter.format(amountDouble);
  }
}
