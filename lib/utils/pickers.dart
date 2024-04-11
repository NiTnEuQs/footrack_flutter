import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:footrack_front/database/ft_providers.dart";

var datePicker = FutureProvider.autoDispose.family<DateTime?, BuildContext>((ref, context) async {
  var languageCode = ref.watch(languageCodeProvider);

  return await showDatePicker(
    context: context,
    locale: Locale(languageCode),
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(3000),
  );
});

var timePicker = FutureProvider.autoDispose.family<TimeOfDay?, BuildContext>((ref, context) async {
  return await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
});

var dateTimePicker = FutureProvider.autoDispose.family<DateTime?, BuildContext>((ref, context) async {
  DateTime? date = await ref.read(datePicker(context).future);
  if (date == null) return Future.value(null);

  TimeOfDay? time = await ref.read(timePicker(context).future);
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
});
