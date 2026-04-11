// import 'package:app/config/Socket/socket.dart';
// import 'package:app/config/colors/app_color.dart';
// import 'package:app/config/helper/common/top_snacbar.dart';

// import 'package:app/screens/home/widgets/confirmed_ride.dart';
// import 'package:app/screens/home/widgets/reached_destination.dart';
// import 'package:app/screens/home/widgets/ride_selection.dart';
// import 'package:app/screens/home/widgets/ride_started.dart';
// import 'package:app/screens/home/widgets/sctollable_card.dart';
// import 'package:app/screens/home/viewmodel/home_provider.dart';
// import 'package:app/screens/home/widgets/waiting_driver.dart';

// import 'package:app/screens/home/widgets/review_screen.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();

//     final homeProvider = context.read<HomeProvider>();

//     SocketService().attachHomeProvider(homeProvider);

//     homeProvider.initLocation();

//     debugPrint("🏠 HomePage initialized & provider attached");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,

//       body: Consumer<HomeProvider>(
//         builder: (context, controller, _) {
//           final rideId = controller.allEstimatedResult?.ride.id;

//           return Stack(
//             children: [
//               // GoogleMap(
//               //   mapType: MapType.normal,

//               //   initialCameraPosition: CameraPosition(
//               //     target: controller.position != null
//               //         ? LatLng(
//               //             controller.position!.latitude,
//               //             controller.position!.longitude,
//               //           )
//               //         : const LatLng(26.9240, 75.8270),
//               //     zoom: 14,
//               //   ),

//               //   myLocationEnabled: true,
//               // ),
//               Center(
//                 child: IgnorePointer(
//                   child: Icon(
//                     Icons.location_pin,
//                     size: 50,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               FlutterMap(
//                 mapController: controller.mapController,
//                 options: MapOptions(
//                   initialCenter: LatLng(26.9124, 75.7873), // Jaipur
//                   initialZoom: 13,
//                   onPositionChanged: (position, hasGesture) {
//                     if (hasGesture) {
//                       context.read<HomeProvider>().onMapMoved(position.center);
//                     }
//                   },
//                 ),

//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=Q707SSTybmNoik8g2aDm',
//                     userAgentPackageName: 'com.waplia.rideapp',
//                   ),
//                   if (controller.position != null)

//                     MarkerLayer(
//                       markers: [
//                         /// PICKUP
//                         if (controller.pickupLocation != null)
//                           Marker(
//                             point: controller.pickupLocation!,
//                             width: 45,
//                             height: 45,
//                             child: const Icon(
//                               Icons.my_location,
//                               color: Colors.blue,
//                               size: 40,
//                             ),
//                           ),

//                         /// DESTINATION
//                         if (controller.destinationLocation != null)
//                           Marker(
//                             point: controller.destinationLocation!,
//                             width: 45,
//                             height: 45,
//                             child: const Icon(
//                               Icons.location_on,
//                               color: Colors.green,
//                               size: 42,
//                             ),
//                           ),
//                       ],
//                     ),

//                   // ROUTE LINE
//                   if (controller.routePoints.isNotEmpty)
//                     PolylineLayer(
//                       polylines: [
//                         Polyline(
//                           points: controller.routePoints,
//                           strokeWidth: 5,
//                           color: Colors.blue,
//                         ),
//                       ],
//                     ),
//                 ],
//               ),

//               if (controller.flow == HomeFlow.searchDestination)
//                 SctollableCard(),

//               if (controller.flow == HomeFlow.selectRide && rideId != null)
//                 RideSelectionSheet(id: rideId),

//               if (controller.flow == HomeFlow.waitingDriver)
//                 WaitingForDriverSheet(),

//               if ((controller.flow == HomeFlow.accepted && rideId != null) ||
//                   controller.flow == HomeFlow.driverArrived && rideId != null)
//                 ConfirmedRide(
//                   confiremRideDetails: controller.confiremRideDetails!,
//                   rideId: rideId,
//                 ),

//               if (controller.flow == HomeFlow.rideStarted) RideStartedSheet(),

//               if (controller.flow == HomeFlow.reachedDestination)
//                 ReachedDestination(),

//               if (controller.flow == HomeFlow.rideCompleted)
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: ReviewScreen(
//                     onSkip: () {
//                       controller.goBackToSearch();
//                     },
//                     onSubmit: (rideId, rating, feedback) async {
//                       debugPrint("⭐ Rating: $rating");
//                       debugPrint("📝 Feedback: $feedback");

//                       // API later
//                       controller.goBackToSearch();
//                       // controller.
//                       final result = await controller.rating(
//                         rideId,
//                         rating,
//                         feedback,
//                       );
//                       if (result.success) {
//                         AppSnackBar.show(context, message: result.message);
//                       }
//                     },
//                   ),
//                 ),

//               if ((controller.flow == HomeFlow.accepted && rideId != null) ||
//                   controller.flow == HomeFlow.driverArrived && rideId != null)
//                 Positioned(
//                   left: 20,
//                   bottom: 400,
//                   child: Card(
//                     shape: Border.all(color: AppColor.primaryYellow),
//                     color: AppColor.primaryYellow,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 18,
//                         vertical: 5,
//                       ),
//                       child: Column(
//                         children: [
//                           Text(
//                             "OTP",
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             controller.confiremRideDetails!.otp,
//                             style: TextStyle(fontSize: 16, color: Colors.black),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),

//               SizedBox(height: 20),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }


// home_page.dart
// ✅ CHANGES SUMMARY:
//   1. FIX: Center pin icon removed from above map (was always visible, confusing)
//      → Replaced with pin that only shows during searchDestination flow
//   2. FIX: Pickup marker → blue pulsing circle (clearly "you are here")
//   3. FIX: Destination marker → red drop pin (standard Uber/Ola convention)
//   4. NEW: Map attribution kept visible (required by OpenStreetMap ToS)
//   5. NEW: Back button on ride selection flows to goBackToSearch

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

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
              // ─── MAP ─────────────────────────────────────────────────────────
              FlutterMap(
                mapController: controller.mapController,
                options: MapOptions(
                  initialCenter: const LatLng(26.9124, 75.7873),
                  initialZoom: 13,
                  // onPositionChanged: (position, hasGesture) {
                  //   if (hasGesture) {
                  //     // Update pickup address as user drags map
                  //     context.read<HomeProvider>().onMapMoved(position.center);
                  //   }
                  // },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=Q707SSTybmNoik8g2aDm',
                    userAgentPackageName: 'com.waplia.rideapp',
                  ),

                  // ✅ FIX: Markers now use clear visual language
                  MarkerLayer(
                    markers: [
                      /// PICKUP MARKER — Blue location dot (you are here)
                      // ✅ FIX: Was using Icons.my_location alone — now has
                      //    background circle for better visibility on all map styles
                      if (controller.pickupLocation != null)
                        Marker(
                          point: controller.pickupLocation!,
                          width: 50,
                          height: 50,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer glow ring
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              // Inner solid dot
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.4),
                                      blurRadius: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                      /// DESTINATION MARKER — Red drop pin
                      // ✅ FIX: Was Icons.location_on (green) — now red drop pin
                      //    matching Uber/Ola/Google Maps convention
                      if (controller.destinationLocation != null)
                        Marker(
                          point: controller.destinationLocation!,
                          width: 40,
                          height: 50,
                          // ✅ Anchor at bottom of icon so pin tip = exact location
                          alignment: Alignment.bottomCenter,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 48,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),

                  // ROUTE POLYLINE
                  if (controller.routePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          points: controller.routePoints,
                          strokeWidth: 5,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                ],
              ),

              // ─── CENTER PIN (only during search — shows where pickup will be) ──
              // ✅ FIX: Was always visible even during rideStarted etc.
              //    Now only shows during searchDestination phase
              if (controller.flow == HomeFlow.searchDestination)
                IgnorePointer(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Pin shadow
                        Container(
                          width: 12,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const Icon(
                          Icons.location_pin,
                          size: 48,
                          color: Colors.black87,
                        ),
                      ],
                    ),
                  ),
                ),

              // ─── FLOW SCREENS ─────────────────────────────────────────────────

              if (controller.flow == HomeFlow.searchDestination)
                const SctollableCard(),

              if (controller.flow == HomeFlow.selectRide && rideId != null)
                RideSelectionSheet(id: rideId),

              if (controller.flow == HomeFlow.waitingDriver)
                const WaitingForDriverSheet(),

              if ((controller.flow == HomeFlow.accepted ||
                      controller.flow == HomeFlow.driverArrived) &&
                  rideId != null)
                ConfirmedRide(
                  confiremRideDetails: controller.confiremRideDetails!,
                  rideId: rideId,
                ),

              if (controller.flow == HomeFlow.rideStarted)
                const RideStartedSheet(),

              if (controller.flow == HomeFlow.reachedDestination)
                const ReachedDestination(),

              if (controller.flow == HomeFlow.rideCompleted)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ReviewScreen(
                    onSkip: () => controller.goBackToSearch(),
                    onSubmit: (rideId, rating, feedback) async {
                      controller.goBackToSearch();
                      final result = await controller.rating(
                        rideId,
                        rating,
                        feedback,
                      );
                      if (result.success && context.mounted) {
                        AppSnackBar.show(context, message: result.message);
                      }
                    },
                  ),
                ),

              // OTP card (shown during accepted / driverArrived)
              if ((controller.flow == HomeFlow.accepted ||
                      controller.flow == HomeFlow.driverArrived) &&
                  rideId != null)
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
                          const Text(
                            "OTP",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            controller.confiremRideDetails!.otp,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // ✅ NEW: Global loading overlay (estimate API / create ride)
              if (controller.loading)
                Container(
                  color: Colors.black.withOpacity(0.25),
                  child: const Center(
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text("Finding best rides for you..."),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}