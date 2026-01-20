import 'package:flutter/material.dart';

class WaitingForDriverSheet extends StatelessWidget {
  const WaitingForDriverSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      minChildSize: 0.45,
      maxChildSize: 0.45,
      builder: (_, __) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                "Looking for the best drivers for you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 30),
 const LinearProgressIndicator(),

   const SizedBox(height: 50),
              /// Driver Searching Animation
              CircleAvatar(
                radius: 60,
                child: SizedBox(
                  height: 420,
                  child: Icon(Icons.person ,size: 50,),
                ),
              ),

              const SizedBox(height: 30),

      
              
            ],
          ),
        );
      },
    );
  }
}
