import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/common_text_field.dart';
import 'package:app/config/helper/common/location_text_field.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/helper/widgets/cylinder_line.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/landingPage/viewModel/landing_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SctollableCard extends StatefulWidget {
  const SctollableCard({super.key});

  @override
  State<SctollableCard> createState() => _SctollableCardState();
}

class _SctollableCardState extends State<SctollableCard> {
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
    final homeController = context.read<HomeProvider>();
    final landingProvider = context.read<LandingProvider>();

    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      maxChildSize: 0.95,
      minChildSize: 0.25,
      expand: true,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
          ),
          child: Column(
            children: [
              /// 🔥 Drag Handle
              const SizedBox(height: 10),
              cylinderLine(),

              const SizedBox(height: 10),

              /// PICKUP + DESTINATION CARD
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        CommonTextField(
                          hintText: "Enter your destination",
                          controller: landingProvider.destinationController,
                          autoFocus: true,
                          // onChanged: searchPlace,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// TITLE
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: const [
                    Text(
                      "Recommended Places",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              /// RECOMMENDATIONS LIST
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: filteredList.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final place = filteredList[index];

                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColor.primaryYellow.withOpacity(.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: AppColor.primaryYellow,
                        ),
                      ),
                      title: Text(
                        place,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
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

                        if (result.success) {
                          homeController.goToRideSelection();
                        }

                        // Navigator.pop(context, {
                        //   "pickup": pickupController.text,
                        //   "destination": place,
                        // });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
