import 'package:app/config/colors/app_color.dart';
import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  PaymentHistoryScreen({super.key});

  /// Static dummy data
  static const List<Map<String, dynamic>> payments = [
    {
      "rideId": "RID123456",
      "date": "17 Feb 2026",
      "time": "10:30 AM",
      "amount": 245.50,
      "method": "UPI",
      "status": "Completed",
      "pickup": "Malviya Nagar",
      "drop": "Jaipur Airport",
    },
    {
      "rideId": "RID123457",
      "date": "16 Feb 2026",
      "time": "08:10 PM",
      "amount": 180.00,
      "method": "Cash",
      "status": "Completed",
      "pickup": "Vaishali Nagar",
      "drop": "MI Road",
    },
    {
      "rideId": "RID123458",
      "date": "15 Feb 2026",
      "time": "02:45 PM",
      "amount": 320.75,
      "method": "Card",
      "status": "Completed",
      "pickup": "Sitapura",
      "drop": "World Trade Park",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ride History")),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: payments.length,
        itemBuilder: (context, index) {
          final payment = payments[index];
          return _buildPaymentCard(payment);
        },
      ),
    );
  }

  Widget _buildPaymentCard(Map<String, dynamic> payment) {
    return Card(
     
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColor.primaryYellow.withOpacity(0.4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row: Amount + Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₹${payment["amount"]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    payment["status"],
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// Pickup
            Row(
              children: [
                const Icon(
                  Icons.circle,
                  size: 10,
                  color: AppColor.primaryYellow,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    payment["pickup"],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            /// Drop
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 14,
                  color: AppColor.primaryYellow,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    payment["drop"],
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),

            const Divider(height: 20),

            /// Bottom Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${payment["date"]}, ${payment["time"]}",
                  style: const TextStyle(color: Colors.grey),
                ),
                Text(
                  payment["method"],
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
