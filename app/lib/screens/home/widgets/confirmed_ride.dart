import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmedRide extends StatelessWidget {
  final dynamic confiremRideDetails;
  final String rideId;
  const ConfirmedRide({
    super.key,
    required this.confiremRideDetails,
    required this.rideId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider controller, Widget? child) {
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

                  Row(
                    children: [
                      Text(
                        "Rj323242",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showCancelRideDialog(context, controller , rideId);
                        },
                        child: const Text(
                          "Cancel ride",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
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
      },
    );
  }
}




Widget _reasonTile({
  required String text,
  required bool selected,
  required VoidCallback onTap,
}) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(
      selected ? Icons.radio_button_checked : Icons.radio_button_off,
      color: selected ? Colors.red : Colors.grey,
    ),
    title: Text(
      text,
      style: TextStyle(
        fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
      ),
    ),
    onTap: onTap,
  );
}

void showCancelRideDialog(BuildContext context, HomeProvider controller , String rideId) {
  String? selectedReason;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text(
              'Cancel Ride',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _reasonTile(
                  text: "Ride is too expensive",
                  selected: selectedReason == "Ride is too expensive",
                  onTap: () {
                    setState(() {
                      selectedReason = "Ride is too expensive";
                    });
                  },
                ),
                _reasonTile(
                  text: "Changed my plan",
                  selected: selectedReason == "Changed my plan",
                  onTap: () {
                    setState(() {
                      selectedReason = "Changed my plan";
                    });
                  },
                ),
                _reasonTile(
                  text: "Driver is too far",
                  selected: selectedReason == "Driver is too far",
                  onTap: () {
                    setState(() {
                      selectedReason = "Driver is too far";
                    });
                  },
                ),
                _reasonTile(
                  text: "Booked by mistake",
                  selected: selectedReason == "Booked by mistake",
                  onTap: () {
                    setState(() {
                      selectedReason = "Booked by mistake";
                    });
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
              TextButton(
                onPressed: selectedReason == null
                    ? null
                    : () async {
                        Navigator.pop(context);

                        final result = await controller.cancelRide(
                          rideId,
                          selectedReason!,
                        );

                        if (result.success) {
                          controller.goBackToSearch();
                        }
                      },
                child: const Text(
                  "Confirm",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}
