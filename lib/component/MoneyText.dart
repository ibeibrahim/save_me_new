// ignore_for_file: non_constant_identifier_names

import 'package:intl/intl.dart';

String MoneyText(String value) {
  final rupiahFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  return rupiahFormatter.format(int.parse(value));
}
