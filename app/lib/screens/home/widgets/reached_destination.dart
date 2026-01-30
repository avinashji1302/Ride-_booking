import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/helper/widgets/cylinder_line.dart';
import 'package:app/screens/home/model/get_due_payment_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';

class ReachedDestination extends StatelessWidget {
  // final RideAcceptedSocketModel rideDetails;

  const ReachedDestination({
    super.key,
    // required this.rideDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, controller, _) {
        return DraggableScrollableSheet(
          initialChildSize: 0.40,
          minChildSize: 0.2,
          maxChildSize: 1,
          builder: (context, scrollController){
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.directions_car, color: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "Reached at your desination",
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
                        Text(" ⭐ 4.3", style: const TextStyle(fontSize: 16)),
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
                      children: [
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
                    Text("Check Your final payment"),
                
                  
                
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 8, 54, 92),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              final result = await controller.getDuePayment(
                                controller.allEstimatedResult!.ride.id,
                              );
                
                              if (result.success) {
                                // AppSnackBar.show(
                                //   context,
                                //   message: result.message,
                                // );
                                finalPaymentScaffold(context, controller.duePayment);
                              } else {
                                AppSnackBar.show(
                                  context,
                                  message: result.message,
                                );
                              }
                            },
                            child: const Text(
                              "Check Final Pay",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                
                        const SizedBox(width: 12),
                
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                               backgroundColor: const Color.fromARGB(255, 8, 54, 92),
                              side: const BorderSide(color: Colors.black),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              final result = await controller.payemntDone(
                                controller.allEstimatedResult!.ride.id,
                              );
                
                              debugPrint("due paymeny : ${result.message}");
                
                              if(result.success){
                                // AppSnackBar.show(
                                //   context,
                                //   message: result.message,
                                // );
                                paymentDone(context);
                                controller.goBackToSearch();
                              }else{
                                AppSnackBar.show(
                                  context,
                                  message: result.message,
                                );
                              }
                
                              AppSnackBar.show(context, message: result.message);
                            },
                            child: const Text(
                              "Paid",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                
                    const SizedBox(height: 10),
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

void finalPaymentScaffold(BuildContext context, GetDuePaymentModel? duePayment) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                'You reached at your destination',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              // Message
              Text(
                'Pay : ${duePayment?.amountToPay ?? "not availble"}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
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


void paymentDone(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
                'Paid',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              // Message
              Text(
                'Thanks for choosing us',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
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