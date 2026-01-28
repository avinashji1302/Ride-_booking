import 'package:app/config/helper/common/draggble_sheet.dart';
import 'package:app/config/helper/common/schedule_time.dart';
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
                    _LocationTextField(
                      icon: Icons.my_location,
                      iconColor: Colors.green,
                      hint: "Current Location",
                      value: homeProvider
                          .allEstimatedResult!
                          .ride
                          .pickupLocation
                          .address,
                    ),

                    const SizedBox(height: 12),

                    /// ───── DROP (FIXED)
                    _LocationTextField(
                      icon: Icons.location_on,
                      iconColor: Colors.red,
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
                          final originalFare = data.estimatedFare.toDouble();
                          final discountedFare = homeProvider.getDiscountedFare(
                            originalFare,
                          );

                          return Material(
                            color: Colors.transparent,
                            clipBehavior: Clip.none,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              onTap: () {
                                homeProvider.vehicleType = data.vehicleType;

                                debugPrint("Typr: ${homeProvider.vehicleType}");
                              },
                              child: ListTile(
                                leading: const Icon(Icons.directions_car),
                                title: Text(
                                  data.vehicleType,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (homeProvider.isCouponApplied)
                                      Text(
                                        "₹${originalFare.toStringAsFixed(0)}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                    Text(
                                      "₹${discountedFare.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: homeProvider.isCouponApplied
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
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
                                  child: homeProvider.loading
                                      ? CircularProgressIndicator()
                                      : !homeProvider.isCouponApplied
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
                            color: Colors.black,
                            child: GestureDetector(
                              onTap: () async {
                                final result = await homeProvider.createRide(
                                  id,
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
                                  child: const Text(
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

                        //  final result = homeProvider.scheduledRide("promoCode", vehicleType, "cash", scheduledTime)

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

class _LocationTextField extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String hint;
  final String value;

  const _LocationTextField({
    required this.icon,
    required this.iconColor,
    required this.hint,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: Icon(icon, color: iconColor),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
