import 'package:flutter/material.dart';


class CallingScreen extends StatelessWidget {
  final String callerLabel; // e.g. "Calling Driver..." or "Calling User..."
  final VoidCallback onCancel;

  const CallingScreen({
    super.key,
    required this.callerLabel,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.call, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            Text(callerLabel,
                style: const TextStyle(color: Colors.white, fontSize: 22)),
            const SizedBox(height: 8),
            const Text("Waiting for answer...",
                style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 50),
            IconButton(
              icon: const Icon(Icons.call_end, color: Colors.red, size: 50),
              onPressed: onCancel,
            ),
            const Text("Cancel",
                style: TextStyle(color: Colors.red, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}