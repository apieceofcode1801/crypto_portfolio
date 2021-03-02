import 'package:intl/intl.dart';

String formatNumber(num number) {
  final f = new NumberFormat("###.##", "en_US");
  return f.format(number);
}
