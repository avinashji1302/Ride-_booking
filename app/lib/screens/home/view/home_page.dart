import 'package:app/config/Socket/socket.dart';
import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/top_snacbar.dart';

import 'package:app/screens/home/widgets/confirmed_ride.dart';
import 'package:app/screens/home/widgets/reached_destination.dart';
import 'package:app/screens/home/widgets/ride_selection.dart';
import 'package:app/screens/home/widgets/ride_started.dart';
import 'package:app/screens/home/widgets/sctollable_card.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/home/widgets/waiting_driver.dart';

import 'package:app/screens/home/widgets/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    final homeProvider = context.read<HomeProvider>();

    SocketService().attachHomeProvider(homeProvider);

    homeProvider.initLocation();

    debugPrint("🏠 HomePage initialized & provider attached");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      body: Consumer<HomeProvider>(
        builder: (context, controller, _) {
          final rideId = controller.allEstimatedResult?.ride.id;

          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,

                initialCameraPosition: CameraPosition(
                  target: controller.position != null
                      ? LatLng(
                          controller.position!.latitude,
                          controller.position!.longitude,
                        )
                      : const LatLng(26.9240, 75.8270),
                  zoom: 14,
                ),

                myLocationEnabled: true,
              ),

              if (controller.flow == HomeFlow.searchDestination)
                SctollableCard(),

              if (controller.flow == HomeFlow.selectRide && rideId != null)
                RideSelectionSheet(id: rideId),

              if (controller.flow == HomeFlow.waitingDriver)
                WaitingForDriverSheet(),

              if ((controller.flow == HomeFlow.accepted && rideId != null) ||
                  controller.flow == HomeFlow.driverArrived && rideId != null)
                ConfirmedRide(
                  confiremRideDetails: controller.confiremRideDetails!,
                  rideId: rideId,
                ),

              if (controller.flow == HomeFlow.rideStarted) RideStartedSheet(),

              if (controller.flow == HomeFlow.reachedDestination)
                ReachedDestination(),

              if (controller.flow == HomeFlow.rideCompleted)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ReviewScreen(
                    onSkip: () {
                      controller.goBackToSearch();
                    },
                    onSubmit: (rideId, rating, feedback) async {
                      debugPrint("⭐ Rating: $rating");
                      debugPrint("📝 Feedback: $feedback");

                      // API later
                      controller.goBackToSearch();
                      // controller.
                      final result = await controller.rating(
                        rideId,
                        rating,
                        feedback,
                      );
                      if (result.success) {
                        AppSnackBar.show(context, message: result.message);
                      }
                    },
                  ),
                ),

              if ((controller.flow == HomeFlow.accepted && rideId != null) ||
                  controller.flow == HomeFlow.driverArrived && rideId != null)
                Positioned(
                  left: 20,
                  bottom: 400,
                  child: Card(
                    shape: Border.all(color: AppColor.primaryYellow),
                    color: AppColor.primaryYellow,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "OTP",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            controller.confiremRideDetails!.otp,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
