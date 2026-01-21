import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideSelectionSheet extends StatelessWidget {
  final String id;
  const RideSelectionSheet({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, _) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 1,
          builder: (context, controller) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                children: [
                  /// Pickup Field
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

                  /// Drop Field
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

                  const SizedBox(height: 10),

                  /// Ride Options
                  Flexible(
                    child: Card(
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        controller: controller,
                        itemCount: homeProvider.allVehicleFares.length,
                        itemBuilder: (context, index) {
                          final data = homeProvider.allVehicleFares[index];
                          homeProvider.vehicleType = data.vehicleType;

                          return ListTile(
                            leading: const Icon(Icons.directions_car),
                            title: Text(data.vehicleType),
                            trailing: Text("₹${data.estimatedFare}"),
                          );
                        },
                      ),
                    ),
                  ),

                  /// Book Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      
                      onPressed: () async {
                        final result = await homeProvider.createRide(id);
                        if (result.success) {
                          homeProvider.goToWaiting();
                        } else {
                          AppSnackBar.show(context, message: result.message);
                        }
                      },
                      child: const Text("Book Ride"),
                    ),
                  ),

                  SizedBox(height: 10,)
                ],
              ),
            );
          },
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
