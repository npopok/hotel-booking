import 'package:intl/intl.dart';

class ValueFormatter {
  static String formatMoney(double money) {
    return NumberFormat("#,###", "en_US").format(money).replaceAll(',', ' ');
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }
}
