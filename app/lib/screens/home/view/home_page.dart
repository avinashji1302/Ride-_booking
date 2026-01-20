import 'package:app/screens/home/widgets/confirmed_ride.dart';
import 'package:app/screens/home/widgets/ride_selection.dart';
import 'package:app/screens/home/widgets/sctollable_card.dart';
import 'package:app/screens/home/view/book_ride_page.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/home/widgets/waiting_driver.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    /// 🔥 Check location once app opens
    Future.microtask(() {
      context.read<HomeProvider>().initLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, controller, _) {
          return Stack(
            children: [
              GoogleMap(
                onMapCreated: controller.onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(20.5937, 78.9629), // India center
                  zoom: 6,
                ),

                markers: controller.marker,
              ),

              if (controller.flow == HomeFlow.searchDestination)
                    SctollableCard(),

              if (controller.flow == HomeFlow.selectRide)
                RideSelectionSheet(
                  id: controller.allEstimatedResult!.ride.id.toString(),
                ),

              if (controller.flow == HomeFlow.waitingDriver)
                WaitingForDriverSheet(),

              if (controller.flow == HomeFlow.rideConfirmed) ConfirmedRide(),
            ],
          );
        },
      ),
    );
  }
}
