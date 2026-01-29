import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';

class RideStartedSheet extends StatelessWidget {
  // final RideAcceptedSocketModel rideDetails;

  const RideStartedSheet({
    super.key,
    // required this.rideDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, controller, _) {
        return DraggableScrollableSheet(
          initialChildSize: 0.55,
          minChildSize: 0.2,
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
                  /// ───── STATUS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.directions_car, color: Colors.green),
                      SizedBox(width: 8),
                      Text(
                        "Ride in progress",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 32),

                  /// ───── VEHICLE + DRIVER
                  Row(
                    children: [
                      Text(
                       controller.confiremRideDetails!.vehicle.number,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        " ⭐ 4.3",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Text(
                    controller.vehicleType,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  /// ───── DESTINATION
                  Row(
                    children:  [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 8),
                      Text(
                        "Destination",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                   Text(
                    controller.allEstimatedResult!.ride.dropLocation.address,
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  /// ───── ETA
                  Row(
                    children: const [
                      Icon(Icons.timer, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        "ETA: 18 mins",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// ───── ACTIONS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _ActionIcon(
                        icon: Icons.call,
                        label: "Call",
                      ),
                      _ActionIcon(
                        icon: Icons.share,
                        label: "Share",
                      ),
                      _ActionIcon(
                        icon: Icons.warning,
                        label: "Emergency",
                        color: Colors.red,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// ───── MESSAGE DRIVER
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Message your driver...",
                      prefixIcon: const Icon(Icons.message),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

/// ───── ACTION ICON WIDGET
class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ActionIcon({
    required this.icon,
    required this.label,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
