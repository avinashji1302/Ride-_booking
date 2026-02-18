import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/location_text_field.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/config/helper/widgets/cylinder_line.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SctollableCard extends StatelessWidget {
  const SctollableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.read<HomeProvider>();

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      maxChildSize: 1,
      minChildSize: 0.25,
      expand: true,
      snap: true,
      snapSizes: const [0.5],
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              cylinderLine(),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: 
                
              

                LocationTextField(icon: Icons.search, iconColor: AppColor.primaryYellow, hint: 'Enter destination', value: '',)
              ),

              const SizedBox(height: 10),
              Divider(height: 1),

              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 3,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    return _locationTile(
                      context,
                      title: "Jaipur Railway Station",
                      subtitle: "Jaipur International Airport",
                      onTap: () async {
                        final result = await home.getAllEstimtedData();

                        debugPrint("resuilt : $result ${result.data} ${result.message} ${result.success}");

                        if (result.success) {
                          AppSnackBar.show(context, message: result.message);
                          home.goToRideSelection();
                        } else {
                          AppSnackBar.show(context, message: result.message);
                        }
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

  // 🌟 BEAUTIFUL LOCATION TILE
  Widget _locationTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                // 📍 ICON
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.location_on, color:AppColor.primaryYellow),
                ),

                const SizedBox(width: 12),

                // 📄 TEXT
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
