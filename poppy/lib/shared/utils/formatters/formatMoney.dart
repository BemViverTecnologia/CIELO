import 'package:intl/intl.dart';

class FormatMoney {
  static String formatToMoney(double value) {
    final nFormat = NumberFormat('.00', 'pt-BR');

    return 'R\$ ${nFormat.format(value)}';
  }
}
