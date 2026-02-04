import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/status_common_dailog.dart';
import 'package:app/config/helper/widgets/cylinder_line.dart';
import 'package:app/screens/chat/view/chat_screen.dart';
import 'package:app/screens/home/model/ride_accepted_socket_model.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmedRide extends StatelessWidget {
  final RideAcceptedSocketModel confiremRideDetails;
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
        if (controller.flow == HomeFlow.driverArrived &&
            !controller.driverArrivedPopupShown) {
          debugPrint("inside..........");
          controller.driverArrivedPopupShown = true;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDriverArrivedSheet(context);
          });
        }
        return DraggableScrollableSheet(
          initialChildSize: 0.40,
          minChildSize: 0.35,
          maxChildSize: .8,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: scrollController, // ⭐ VERY IMPORTANT
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    cylinderLine(),
                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 18,
                          color: AppColor.primaryYellow,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          controller.flow == HomeFlow.driverArrived
                              ? "Driver has arrived"
                              : "Your driver is coming in 3 min",
                          style: const TextStyle(
                            fontSize: 18,
                            color: AppColor.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const Divider(),

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
                                confiremRideDetails.driver.fullName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "Distance : ${confiremRideDetails.ride.distance.toString()}km",
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

                    const Divider(),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColor.primaryYellow,
                          width: 1.2,
                        ),
                      ),
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Payment method",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColor.grey,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Text(
                                controller.selectedPayment,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "₹${confiremRideDetails.ride.finalFare.toStringAsFixed(0)}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        _roundIcon(Icons.call),
                        const SizedBox(width: 12),
                        GestureDetector(onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ChatScreen()));
                        },child: _roundIcon(Icons.message)),
                        Spacer(),

                        Card(
                          color: AppColor.primaryYellow,
                          child: GestureDetector(
                            onTap: () async {
                              debugPrint("ride id : ${rideId}");
                              showCancelRideDialog(context, controller, rideId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 20,
                              ),
                              child: Center(
                                child: const Text(
                                  "Cancel Ride",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

Widget _roundIcon(IconData icon) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColor.primaryYellow, width: 1.5),
    ),
    child: Icon(icon, color: AppColor.primaryYellow),
  );
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

void showCancelRideDialog(
  BuildContext context,
  HomeProvider controller,
  String rideId,
) {
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

// void showDriverArrivedSheet(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Icon
//               Container(
//                 padding: const EdgeInsets.all(14),
//                 decoration: const BoxDecoration(
//                   color: Colors.green,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.bike_scooter,
//                   color: Colors.white,
//                   size: 32,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Title
//               const Text(
//                 'Driver Arrived',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),

//               const SizedBox(height: 8),

//               // Message
//               const Text(
//                 'Your driver has arrived at the pickup location.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 14, color: Colors.black54),
//               ),

//               const SizedBox(height: 20),

//               // Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColor.primaryYellow,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 12),
//                   ),
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text(
//                     'OK',
//                     style: TextStyle(color: AppColor.black),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }



void showDriverArrivedSheet(BuildContext context) {
  showCommonStatusDialog(
    context: context,
    icon: Icons.bike_scooter,
    title: "Driver Arrived",
    message: "Your driver has arrived at the pickup location.",
  );
}
