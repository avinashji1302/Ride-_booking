import 'package:app/config/helper/common/common_text_field.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/map/map_constants.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/landingPage/viewModel/landing_provider.dart';
import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class SearchRideScreen extends StatefulWidget {
  const SearchRideScreen({super.key});

  @override
  State<SearchRideScreen> createState() => _SearchRidePageState();
}

class _SearchRidePageState extends State<SearchRideScreen> {
  late TextEditingController pickupController;

  final List<String> recommendations = [
    "Jaipur Airport",
    "Railway Station",
    "World Trade Park",
    "Vaishali Nagar",
    "Malviya Nagar",
    "MI Road",
  ];

  List<String> filteredList = [];

  @override
  void initState() {
    super.initState();
    // ✅ Read from provider — address is now always live
    final address = context.read<LandingProvider>().currentAddress;
    pickupController = TextEditingController(
      text: address.isNotEmpty ? address : "Current Location",
    );
    filteredList = recommendations;
  }

  void searchPlace(String value) {
    filteredList = recommendations
        .where((e) => e.toLowerCase().contains(value.toLowerCase()))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final homeController = context.watch<HomeProvider>();
    final landingProvider = context.watch<LandingProvider>();
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Plan your ride",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Column(
        children: [
          /// PICKUP + DESTINATION CARD
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                CommonTextField(
                  hintText: "Pickup location",
                  controller: pickupController,
                  autoFocus: false,
                ),

                const Divider(),

                CommonTextField(
                  hintText: "Where to?",
                  controller: landingProvider.destinationController,
                  autoFocus: true,
                ),
              ],
            ),
          ),

          /// RECOMMENDATIONS
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final place = filteredList[index];

                return ListTile(
                  leading: const Icon(Icons.location_on_outlined),
                  title: Text(place),
                  subtitle: const Text("Recommended destination"),
                  onTap: () async {
                    final result = await homeController.getAllEstimtedData(
                      pickupAddress: pickupController.text,
                      pickupLat: landingProvider.position?.latitude ?? 0.0,
                      pickupLng: landingProvider.position?.longitude ?? 0.0,
                      dropAddress: place,
                      dropLat: 26.9126,
                      dropLng: 75.7441,
                    );

                    debugPrint(
                      "resuilt : $result ${result.data} ${result.message} ${result.success}",
                    );

                    if (result.success) {
                      AppSnackBar.show(context, message: result.message);
                      landingProvider.changeBottemNav(1);
                      homeController.goToRideSelection();
                    } else {
                      AppSnackBar.show(context, message: result.message);
                    }

                    LatLng destination = LatLng(26.9126, 75.7441);
                    LatLng origin = LatLng(
                      landingProvider.position?.latitude ?? 0.0,
                      landingProvider.position?.longitude ?? 0.0,
                    );

                    debugPrint("oriin : $origin desination $destination ");

                    Navigator.pop(context, {
                      "pickup": pickupController.text,
                      "destination": place,
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
