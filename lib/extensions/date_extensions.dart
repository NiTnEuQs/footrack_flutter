import "package:cloud_firestore/cloud_firestore.dart";
import "package:footrack_front/converters/date_time_converter.dart";
import "package:intl/intl.dart";

extension DateFormatting on DateTime? {
  String format() {
    return this != null ? DateFormat("dd/MM/yyyy").format(this!) : "";
  }

  String formatWithTime() {
    return this != null ? DateFormat("dd/MM/yyyy HH:mm").format(this!) : "";
  }

  String formatWithTimeAndDay() {
    return this != null ? DateFormat("EEEE dd/MM/yyyy HH:mm").format(this!) : "";
  }

  bool hasPassed({Duration? add}) {
    var currentDate = this?.add(add ?? const Duration());
    var comparedDate = DateTime.now();
    var res = currentDate?.compareTo(comparedDate);
    return res?.isNegative == true;
  }
}

extension TimestampExtension on Timestamp? {
  DateTime? toDateTime() {
    return this != null ? const DateTimeConverter().fromJson(this!) : null;
  }

  bool hasPassed({Duration? add}) {
    return toDateTime().hasPassed(add: add);
  }
}

extension DateTimeExtension on DateTime? {
  Timestamp? toTimestamp() {
    return this != null ? const DateTimeConverter().toJson(this!) : null;
  }
}

extension StringFormatting on String? {
  DateTime? toDate() {
    return this != null ? DateTime.parse(this!) : null;
  }
}
