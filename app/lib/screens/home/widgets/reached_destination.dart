import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/status_common_dailog.dart';
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
          initialChildSize: 0.38,
          minChildSize: 0.2,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                        Icon(
                          Icons.directions_car,
                          color: AppColor.primaryYellow,
                        ),
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
                    SizedBox(height: 20),
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

                    /// ───── ETA
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryYellow,
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
                                finalPaymentScaffold(
                                  context,
                                  controller.duePayment,
                                );
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: AppColor.primaryYellow,
                              side: BorderSide(color: AppColor.primaryYellow),
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

                              if (result.success) {
                                // AppSnackBar.show(
                                //   context,
                                //   message: result.message,
                                // );
                                paymentDone(context);
                                controller.goBackToSearch();
                              } else {
                                AppSnackBar.show(
                                  context,
                                  message: result.message,
                                );
                              }

                              AppSnackBar.show(
                                context,
                                message: result.message,
                              );
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

                    const SizedBox(height: 20),
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

// void finalPaymentScaffold(
//   BuildContext context,
//   GetDuePaymentModel? duePayment,
// ) {
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
//                   Icons.directions_bike,
//                   color: Colors.white,
//                   size: 32,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Title
//               const Text(
//                 'You reached at your destination',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//               ),

//               const SizedBox(height: 8),

//               // Message
//               Text(
//                 'Pay : ${duePayment?.amountToPay ?? "not availble"}',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18, color: Colors.black54),
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
//                   child: const Text('OK'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }

void finalPaymentScaffold(
  BuildContext context,
  GetDuePaymentModel? duePayment,
) {
  showCommonStatusDialog(
    context: context,
    icon: Icons.flag,
    title: "You reached your destination",
    message: "Pay ₹${duePayment?.amountToPay ?? 'N/A'}",
  );
}


void paymentDone(BuildContext context) {
  showCommonStatusDialog(
    context: context,
    icon: Icons.check_circle,
    title: "Payment Successful",
    message: "Thanks for choosing us",
  );
}


// void paymentDone(BuildContext context) {
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
//                   Icons.directions_bike,
//                   color: Colors.white,
//                   size: 32,
//                 ),
//               ),

//               const SizedBox(height: 16),

//               // Title
//               const Text(
//                 'Paid',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//               ),

//               const SizedBox(height: 8),

//               // Message
//               Text(
//                 'Thanks for choosing us',
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
//                   child: const Text('OK'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
