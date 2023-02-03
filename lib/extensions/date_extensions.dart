import 'package:intl/intl.dart';

extension DateFormatting on DateTime? {
  String format() {
    return this != null ? DateFormat("dd/MM/yyyy").format(this!) : "";
  }

  String formatWithTime() {
    return this != null ? DateFormat("dd/MM/yyyy HH:mm").format(this!) : "";
  }

  bool hasPassed() {
    return this?.compareTo(DateTime.now()).isNegative == true;
  }
}

extension StringFormatting on String? {
  DateTime? toDate() {
    return this != null ? DateTime.parse(this!) : null;
  }
}
