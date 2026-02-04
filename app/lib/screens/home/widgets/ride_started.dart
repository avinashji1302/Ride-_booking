import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/widgets/cylinder_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';



class RideStartedSheet extends StatelessWidget {
  const RideStartedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, controller, _) {
        return DraggableScrollableSheet(
          initialChildSize: 0.50,
          minChildSize: 0.25,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cylinderLine(),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.directions_car, color: Colors.yellow),
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

                    const Divider(),

                    const SizedBox(height: 14),

                    /// DRIVER + VEHICLE
                    // Card(
                    //   elevation: 2,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(12),
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(12),
                    //     child: Row(
                    //       children: [
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               controller.confiremRideDetails!
                    //                   .vehicle.number,
                    //               style: const TextStyle(
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.bold,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 4),
                    //             Text(
                    //               controller.vehicleType,
                    //               style: const TextStyle(color: Colors.grey),
                    //             ),
                    //           ],
                    //         ),
                    //         const Spacer(),
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.end,
                    //           children: [
                    //             Text(
                    //               controller.confiremRideDetails?.driver
                    //                       .fullName ??
                    //                   "Unknown",
                    //               style: const TextStyle(
                    //                 fontWeight: FontWeight.w600,
                    //               ),
                    //             ),
                    //             const SizedBox(height: 4),
                    //             const Text("⭐ 4.3"),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 26,
                          backgroundImage: NetworkImage(
                            "https://www.shutterstock.com/image-photo/mid-adult-man-smiling-while-600nw-2237515123.jpg",
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.confiremRideDetails!.driver.fullName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Distance : ${controller.confiremRideDetails!.ride.distance.toString()}km",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColor.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: AppColor.primaryYellow,
                                  ),
                                  SizedBox(width: 4),
                                  Text("4.3", style: TextStyle(fontSize: 13)),
                                  SizedBox(width: 8),
                                  Text(
                                    "• 800m (3min away)",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Image.network(
                          "https://img.freepik.com/premium-psd/realistic-modern-car-isolated-background-3d-rendering-illustration_494250-129716.jpg?semt=ais_hybrid&w=740&q=80",
                          height: 55,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// DISTANCE + ETA
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.route,
                          text:
                              "${controller.confiremRideDetails!.ride.distance} km",
                        ),
                        const SizedBox(width: 10),
                        const _InfoChip(icon: Icons.timer, text: "18 mins ETA"),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// DESTINATION
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 18,
                              ),
                              SizedBox(width: 6),
                              Text(
                                "Destination",
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            controller
                                .allEstimatedResult!
                                .ride
                                .dropLocation
                                .address,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// ACTIONS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _ActionIcon(
                          icon: Icons.call,
                          label: "Call",
                          color: AppColor.primaryYellow,
                        ),
                        _ActionIcon(
                          icon: Icons.share,
                          label: "Share",
                          color: AppColor.primaryYellow,
                        ),
                        _ActionIcon(
                          icon: Icons.warning,
                          label: "Emergency",
                          color: Colors.red,
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
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

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryYellow),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColor.primaryYellow),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}


