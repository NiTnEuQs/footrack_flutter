import 'package:flutter/material.dart';

Future<DateTime?> datePicker(context) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(3000),
  );
}

Future<TimeOfDay?> timePicker(context) async {
  return await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
}

Future<DateTime?> dateTimePicker(context) async {
  DateTime? date = await datePicker(context);
  if (date == null) return Future.value(null);

  TimeOfDay? time = await timePicker(context);
  if (time == null) return Future.value(null);

  return Future.value(
    DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ),
  );
}
