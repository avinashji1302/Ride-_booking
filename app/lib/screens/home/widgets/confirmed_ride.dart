import 'package:flutter/material.dart';

class ConfirmedRide extends StatelessWidget {
  const ConfirmedRide({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.55,
      maxChildSize: 1,
      builder: (_, __) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.check_circle, color: Colors.green),
                  SizedBox(width: 8),
                  Text(
                    "Your ride is confirmed",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),

              Divider(),

              const SizedBox(height: 20),

              Text(
                "Rj323232",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
               const SizedBox(height: 10),
                Text("Splender"),
                 const SizedBox(height: 10),
              Text("${"Avinash"} ⭐ ${4.3}"),

              const SizedBox(height: 20),
              Spacer(),
              TextField(
                decoration: InputDecoration(
                  hintText: "Message your driver...",
                  prefixIcon: const Icon(Icons.message),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
