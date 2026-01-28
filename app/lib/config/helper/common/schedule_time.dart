import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<String?> pickDateTime(BuildContext context) async {
  // 1. Pick Date
  final DateTime? date = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 30)),
  );

  if (date == null) return null;

  // 2. Pick Time
  final TimeOfDay? time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (time == null) return null;

  // 3. Combine Date + Time
  final DateTime selectedDateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );

  // 4. 15 min validation
  final DateTime minAllowedTime =
      DateTime.now().add(const Duration(minutes: 15));

  if (selectedDateTime.isBefore(minAllowedTime)) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please select a time at least 15 minutes from now"),
      ),
    );
    return null;
  }

  // 5. Format for API
  final String scheduledFor =
      DateFormat('dd/MM/yyyy HH:mm').format(selectedDateTime);

  debugPrint("Selected DateTime: $selectedDateTime");
  debugPrint("API Format: $scheduledFor");

  return scheduledFor;
}
