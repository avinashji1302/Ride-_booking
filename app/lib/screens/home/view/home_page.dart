import 'package:app/config/Socket/socket.dart';
import 'package:app/config/helper/common/draggble_sheet.dart';
import 'package:app/screens/Auth/View/signIn/sign_in_page.dart';
import 'package:app/screens/Auth/ViewModel/sign_in_provider.dart';
import 'package:app/screens/home/widgets/confirmed_ride.dart';
import 'package:app/screens/home/widgets/reached_destination.dart';
import 'package:app/screens/home/widgets/ride_selection.dart';
import 'package:app/screens/home/widgets/ride_started.dart';
import 'package:app/screens/home/widgets/sctollable_card.dart';
import 'package:app/screens/home/view/book_ride_page.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/home/widgets/waiting_driver.dart';
import 'package:app/screens/ola_money/view/ola_money.dart';
import 'package:app/screens/ola_money/view_model/ola_money_provider.dart';
import 'package:app/screens/profile/view/user_profile.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
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
    final profileProvider = context.read<ProfileProvider>();


    SocketService().attachHomeProvider(homeProvider);

    homeProvider.initLocation();
     profileProvider.getProfile();

    debugPrint("🏠 HomePage initialized & provider attached");
  }

  @override
  Widget build(BuildContext context) {
    // final pofileProvider = context.watch<ProfileProvider>();
      final oldMoneyProvider = context.watch<OlaMoneyProvider>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Consumer<ProfileProvider>(
          builder:
              (
                BuildContext context,
                ProfileProvider profileProvider,
                Widget? child,
              ) {
                return SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 40,
                              child: Icon(Icons.person, size: 32),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              profileProvider.userDetails?.fullName ??
                                  "user name not found",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Text(
                              profileProvider.userDetails?.email ??
                                  "email not found",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Divider(),

                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            ListTile(
                              leading: Icon(Icons.home),
                              title: Text("Home"),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final response = await profileProvider
                                    .getProfile();

                                if (response.success) {
                                  debugPrint(
                                    " : ${response.message}",
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UserProfile(),
                                    ),
                                  );
                                } else {
                                  if (response.success) {
                                    debugPrint(
                                      " : ${response.message}",
                                    );
                                  }
                                }
                              },
                              child: ListTile(
                                leading: Icon(Icons.person),
                                title: Text("Profile"),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.add_location),
                              title: Text("History"),
                            ),
                            GestureDetector(
                              onTap: () async {
                                final response = await profileProvider
                                    .getProfile();
                                    final olaResponseData = await oldMoneyProvider.olaMoneyPayHistoryStatus();

                                    debugPrint("ola response : $olaResponseData");

                                if (response.success) {
                                  debugPrint(
                                    " : ${response.message}",
                                  );

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => OlaMoney(),
                                    ),
                                  );
                                } else {
                                  if (response.success) {
                                    debugPrint(
                                      " : ${response.message}",
                                    );
                                  }
                                }
                              },
                              child: ListTile(
                                leading: Icon(Icons.currency_rupee_sharp),
                                title: Text("Ola Money"),
                              ),
                            ),
                            ListTile(
                              leading: Icon(Icons.currency_exchange_outlined),
                              title: Text("Payments"),
                            ),
                            ListTile(
                              leading: Icon(Icons.info),
                              title: Text("About"),
                            ),
                          ],
                        ),
                      ),

                      const Divider(),

                      ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () async {
                          final response = await profileProvider.logout();

                          if (response.success) {
                            debugPrint(
                              " : ${response.message}",
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignInPage()),
                            );
                          } else {
                            if (response.success) {
                              debugPrint(
                                " : ${response.message}",
                              );
                            }
                          }
                        },
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                );
              },
        ),
      ),

      body: Consumer<HomeProvider>(
        builder: (context, controller, _) {
          final rideId = controller.allEstimatedResult?.ride.id;

          return Stack(
            children: [
              GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: controller.position != null
                      ? LatLng(
                          controller.position!.latitude,
                          controller.position!.longitude,
                        )
                      : const LatLng(26.9240, 75.8270),
                  zoom: 14,
                ),
                markers: controller.markers,
                polylines: controller.polylines,
                myLocationEnabled: true,
              ),

              Positioned(
                left: 10,
                top: 30,
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Card(
                    shape: const CircleBorder(),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(Icons.menu),
                    ),
                  ),
                ),
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
            ],
          );
        },
      ),
    );
  }
}
