import 'package:app/config/helper/widgets/cylinder_line.dart';
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
          initialChildSize: 0.55,
          minChildSize: 0.35,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 5),
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
                    controller.flow == HomeFlow.driverArrived
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                "Driver is arrived",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          )
                        : Row(
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

                    const Divider(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          confiremRideDetails.vehicle.number,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showCancelRideDialog(
                                  context,
                                  controller,
                                  rideId,
                                );
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
                            Text("Start with OTP : ${confiremRideDetails.otp}"),
                          ],
                        ),
                      ],
                    ),

                    Text(confiremRideDetails.vehicle.type),
                    const SizedBox(height: 10),
                    Text("${confiremRideDetails.driver.fullName} ⭐ 4.3"),

                    const SizedBox(height: 40), // 👈 instead of Spacer

                    TextField(
                      decoration: InputDecoration(
                        hintText: "Message your driver...",
                        prefixIcon: const Icon(Icons.message),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40), // allows drag

                    Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              child: Text(
                                "Popular Fare:₹${confiremRideDetails.ride.finalFare.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(Icons.money),
                              title: Text(controller.selectedPayment),
                              trailing: Text("Change"),
                            ),
                          ],
                        ),
                      ),
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

void showDriverArrivedSheet(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(14),
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.directions_bike,
                  color: Colors.white,
                  size: 32,
                ),
              ),

              const SizedBox(height: 16),

              // Title
              const Text(
                'Driver Arrived',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              // Message
              const Text(
                'Your driver has arrived at the pickup location.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 20),

              // Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
