import 'package:intl/intl.dart';

class HerdeiroModel {
  String title;
  double percentage;
  double value;
  String? get fractionedValue {
    NumberFormat formatter = NumberFormat.simpleCurrency();
    // ignore: unused_local_variable
    String stringValue;
    return stringValue = formatter.format((value * percentage) / 100);
  }

  HerdeiroModel({
    required this.title,
    required this.percentage,
    required this.value,
  });
}
