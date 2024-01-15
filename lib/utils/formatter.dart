import 'package:intl/intl.dart';

class Formatter {
  static String formatMoney(double money) {
    return NumberFormat("#,###", "en_US").format(money).replaceAll(',', ' ');
  }
}
