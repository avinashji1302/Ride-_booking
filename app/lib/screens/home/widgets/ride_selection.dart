import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/draggble_sheet.dart';
import 'package:app/config/helper/common/schedule_time.dart';
import 'package:app/config/helper/common/location_text_field.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/home/widgets/payment_mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RideSelectionSheet extends StatelessWidget {
  final String id;
  const RideSelectionSheet({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        return Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.55, // FIXED HEIGHT
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    /// ───── PICKUP (FIXED)
                    LocationTextField(
                      icon: Icons.my_location,
                       iconColor: AppColor.primaryYellow,
                      hint: "Current Location",
                      value: homeProvider
                          .allEstimatedResult!
                          .ride
                          .pickupLocation
                          .address,
                    ),

                    const SizedBox(height: 12),

                    /// ───── DROP (FIXED)
                    LocationTextField(
                      icon: Icons.location_on,
                      iconColor: AppColor.primaryYellow,
                      hint: "Destination Location",
                      value: homeProvider
                          .allEstimatedResult!
                          .ride
                          .dropLocation
                          .address,
                    ),

                    // const SizedBox(height: 12),

                    /// ───── ONLY THIS SCROLLS
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: homeProvider.allVehicleFares.length,
                        itemBuilder: (context, index) {
                          final data = homeProvider.allVehicleFares[index];

                          debugPrint("Estimated data : $data");
                          final originalFare = (data.estimatedFare).toDouble();

                          final discountedFare = homeProvider.getDiscountedFare(
                            originalFare,
                          );

                          final bool isSelected =
                              homeProvider.vehicleType == data.vehicleType;

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            height:  50, // 👈 height highlight
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.primaryYellow.withOpacity(0.12)
                                  : Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppColor.primaryYellow
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () {
                                homeProvider.vehicleType = data.vehicleType;
                                homeProvider.notifyListeners();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.directions_car,
                                    color: isSelected
                                        ? AppColor.primaryYellow
                                        : Colors.grey,
                                  ),

                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Text(
                                      data.vehicleType,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.grey.shade800,
                                      ),
                                    ),
                                  ),

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (homeProvider.isCouponApplied)
                                        Text(
                                          "₹${originalFare.toStringAsFixed(0)}",
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Colors.grey,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                      Text(
                                        "₹${discountedFare.toStringAsFixed(0)}",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected
                                              ? AppColor.primaryYellow
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    /// ───── BOOK BUTTON (FIXED)
                    ///
                    SizedBox(
                      width: double.infinity,
                      height: 120,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Divider(color: Colors.grey),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.attach_money),
                                    SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () {
                                        showDraggableSheet(
                                          context,
                                          child: PaymentMode(
                                            onSubmit: (value) {
                                              homeProvider.updatePaymeentmode(
                                                value,
                                              );

                                              debugPrint(
                                                "Selected Payemnt : ${homeProvider.selectedPayment}",
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Text(
                                        homeProvider.selectedPayment,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(
                                  height: 20,
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 2,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    // 👇 If already applied → REMOVE

                                    debugPrint(
                                      "rideId : ${homeProvider.isCouponApplied} us",
                                    );
                                    if (homeProvider.isCouponApplied) {
                                      homeProvider.isCouponApplied = false;
                                      homeProvider.discountPercent = null;

                                      homeProvider.notifyListeners();

                                      AppSnackBar.show(
                                        context,
                                        message: "Coupon removed",
                                      );
                                      return;
                                    }

                                    final rideId = homeProvider
                                        .allEstimatedResult!
                                        .ride
                                        .id;
                                    final userId = await AuthStorage()
                                        .getUserId();
                                    debugPrint("rideId : $rideId user $userId");
                                    final coupnCode = "TEST5";
                                    final result = await homeProvider
                                        .applyCoupon(
                                          coupnCode,
                                          userId!,
                                          rideId,
                                        );

                                    if (result.success) {
                                      debugPrint(result.message);
                                      homeProvider.isCouponApplied =
                                          !homeProvider.isCouponApplied;

                                      AppSnackBar.show(
                                        context,
                                        message: "Coupon Applied",
                                      );

                                      // homeProvider.applyCouponToFare(fare: fare, discountPercent:homeProvider.coupnResponse!.discount!.discountValue, couponCode: couponCode)
                                    } else {
                                      debugPrint(result.message);
                                    }
                                  },
                                  child:  !homeProvider.isCouponApplied
                                      ? Row(
                                          children: [
                                            Icon(Icons.local_offer),
                                            SizedBox(width: 15),
                                            Text(
                                              "Coupon",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green.shade50,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Text(
                                            "Applied",
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                ),

                                SizedBox(
                                  height: 20,
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: 2,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () async {
                                    //   final String? promoCode = homeProvider.coupnResponse!.discount!.code;
                                    final String paymentMethod = homeProvider
                                        .allEstimatedResult!
                                        .ride
                                        .paymentMethod;
                                    final String vehicleType =
                                        homeProvider.vehicleType;
                                    final scheduledTime = await pickDateTime(
                                      context,
                                    );
                                    debugPrint(
                                      "calling schedule :  $paymentMethod , $vehicleType, $scheduledTime",
                                    );
                                    homeProvider.scheduledRide(
                                      "TEST5",
                                      'mini',
                                      paymentMethod,
                                      scheduledTime!,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 15),
                                      Text(
                                        "Myself",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 10),
                          Container(
                            color: AppColor.primaryYellow,
                            child: GestureDetector(
                              onTap: () async {
                                final result = await homeProvider.createRide(
                                  id,
                                );

                                debugPrint(
                                  "message : ${result.message} ${result.data}",
                                );
                                if (result.success) {
                                  homeProvider.goToWaiting();
                                } else {
                                  AppSnackBar.show(
                                    context,
                                    message: result.message,
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child:  Text(
                                    "Book Ride",
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
                    ),

                    SizedBox(height: 20),
                  ],
                ),

                Positioned(
                  top: 30,
                  right: 5,
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.grey,
                    elevation: 10,
                    child: GestureDetector(
                      onTap: () async {
                        final scheduledTime = await pickDateTime(context);
                        if (scheduledTime == null) {
                          return;
                        }

                        print(scheduledTime);
                      },
                      child: FaIcon(FontAwesomeIcons.alarmClock),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// class _LocationTextField extends StatelessWidget {
//   final IconData icon;
//   final Color iconColor;
//   final String hint;
//   final String value;

//   const _LocationTextField({
//     required this.icon,
//     required this.iconColor,
//     required this.hint,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 44, 
//       child: TextField(
//         readOnly: true,
//         controller: TextEditingController(text: value),
//         style: const TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.w500,
//         ),
//         decoration: InputDecoration(
//           prefixIcon: Icon(icon, color: iconColor, size: 20),
//           hintText: hint,
//           isDense: true, 
//           contentPadding: const EdgeInsets.symmetric(vertical: 10),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(
//               color: AppColor.primaryYellow, 
//               width: 1.2,
//             ),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//             borderSide: const BorderSide(
//               color: AppColor.primaryYellow,
//               width: 1.4,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

