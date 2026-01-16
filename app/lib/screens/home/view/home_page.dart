import 'package:app/config/helper/widgets/ride_selection.dart';
import 'package:app/config/helper/widgets/sctollable_card.dart';
import 'package:app/screens/home/view/book_ride_page.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder:
            (BuildContext context,  controller, Widget? child) {
              return Stack(
        children: [
           GoogleMap(initialCameraPosition: _kGooglePlex),

           Positioned(
            top: 100,
            left: 100,
             child: GestureDetector(
              onTap: () async{
                debugPrint("Tapped::");
               await controller.permisson();
              },
              child: Icon(Icons.home , size: 80,)),
           ),
          if (controller.flow == HomeFlow.searchDestination)
            const SctollableCard(),
          if (controller.flow == HomeFlow.selectRide)
            const RideSelectionSheet(),
        ],
              );
            },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,

        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(onTap: () {}, child: Icon(Icons.home, size: 32)),
              Icon(Icons.access_alarm, size: 32),
              Icon(Icons.person, size: 32),
            ],
          ),
        ),
      ),
    );
  }
}
