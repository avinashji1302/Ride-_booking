import 'package:app/config/colors/app_color.dart';
import 'package:app/config/device/location_permission.dart';
import 'package:app/config/helper/common/common_text_field.dart';
import 'package:app/config/helper/widgets/cylinder_line.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/landingPage/viewModel/landing_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// class SctollableCard extends StatelessWidget {
//   const SctollableCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final homeProvider = context.watch<HomeProvider>();

//     return DraggableScrollableSheet(
//       initialChildSize: 0.45,
//       maxChildSize: 0.95,
//       minChildSize: 0.25,
//       builder: (context, scrollController) {
//         return Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//             boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
//           ),

//           child: Column(
//             children: [
//               const SizedBox(height: 12),

//               /// SEARCH FIELD
//               Stack(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: CommonTextField(
//                       controller: homeProvider.desinationController,
//                       onChanged: homeProvider.searchDestination,
//                       hintText: 'Search your desination',
//                     ),
//                   ),

//                   Positioned(
//                     right: 20,
//                     top: 20,
//                     child: GestureDetector(
//                       onTap: () {
//                         homeProvider.desinationController.clear();
//                       },
//                       child: Container(
//                         color: Colors.white,
//                         child: Icon(Icons.cancel, color: Colors.red),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               //               /// TITLE
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18),
//                 child: Row(
//                   children: const [
//                     Text(
//                       "Recommended Places",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               /// SUGGESTIONS
//               Expanded(
//                 child: ListView.builder(
//                   controller: scrollController,
//                   itemCount: homeProvider.destinationSuggestions.length,

//                   itemBuilder: (context, index) {
//                     final place = homeProvider.destinationSuggestions[index];

//                     return ListTile(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       leading: Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: AppColor.primaryYellow.withOpacity(.15),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Icon(
//                           Icons.location_on,
//                           color: AppColor.primaryYellow,
//                         ),
//                       ),
//                       title: Text(
//                         place.displayName,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),

//                       // onTap: () {
//                       //   // homeProvider.selectDestination(place);
//                       // },
//                       onTap: () async {
//                         homeProvider.selectDestination(place);
//                         final result = await homeProvider.getAllEstimtedData(
//                           pickupAddress: homeProvider.pickupAddress,
//                           pickupLat:
//                               homeProvider.pickupLocation?.latitude ?? 0.0,
//                           pickupLng:
//                               homeProvider.pickupLocation?.longitude ?? 0.0,
//                           dropAddress: homeProvider.desinationController.text,
//                           dropLat:
//                               homeProvider.destinationLocation?.latitude ??
//                               26.9126,
//                           dropLng:
//                               homeProvider.destinationLocation?.longitude ??
//                               75.7441,
//                         );

//                         if (result.success) {
//                           homeProvider.goToRideSelection();
//                         }

//                         // Navigator.pop(context, {
//                         //   "pickup": pickupController.text,
//                         //   "destination": place,
//                         // });
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }



// scrollable_card.dart
// ✅ CHANGES SUMMARY:
//   1. NEW: Shimmer loading animation while fetching suggestions
//   2. NEW: Recent search history shown when field is empty (with clock icon)
//   3. NEW: "Use current location" button at top
//   4. NEW: Empty state when no results found
//   5. FIX: Cancel icon now only shows when text is non-empty
//   6. NEW: Pickup address bar shown at top of sheet (Uber-style)
//   7. NEW: Suggestion items show short address (city/district only)
//   8. NEW: Loading overlay when estimate API is in progress

// import 'package:app/config/colors/app_color.dart';
// import 'package:app/screens/home/service/location_service.dart';
// import 'package:app/screens/home/viewmodel/home_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class SctollableCard extends StatelessWidget {
  const SctollableCard({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return DraggableScrollableSheet(
      initialChildSize: 0.45,
      maxChildSize: 0.95,
      minChildSize: 0.25,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12)],
          ),
          child: Column(
            children: [
              // ✅ Drag handle indicator (Uber-style)
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 12),

              // ✅ NEW: Pickup address bar (shows current location — Uber style)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Green dot = pickup
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        homeProvider.pickupAddress.isEmpty
                            ? "Fetching your location..."
                            : homeProvider.pickupAddress,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Dashed vertical line connecting pickup → destination (Uber style)
              Padding(
                padding: const EdgeInsets.only(left: 21),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 18,
                    child: CustomPaint(
                      painter: _DashedLinePainter(),
                      size: const Size(2, 18),
                    ),
                  ),
                ),
              ),

              /// DESTINATION SEARCH FIELD
              // ✅ FIX: Cancel icon only shows when text is non-empty
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    // Red dot = destination
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red.shade400,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: homeProvider.desinationController,
                        onChanged: homeProvider.searchDestination,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          hintText: 'Where to?',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColor.primaryYellow,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          // ✅ FIX: Only show clear button when text is non-empty
                          suffixIcon: homeProvider
                                  .desinationController
                                  .text
                                  .isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    homeProvider.desinationController.clear();
                                    // ✅ show recent searches after clearing
                                    homeProvider.searchDestination('');
                                  },
                                )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ✅ NEW: "Use current location" quick-select button (Ola/Uber feature)
              InkWell(
                onTap: () async {
                  if (homeProvider.pickupAddress.isNotEmpty &&
                      homeProvider.pickupLocation != null) {
                    // ✅ Set destination = current location (useful for "take me home")
                    final currentPlace = LocationSearchModel(
                      displayName: homeProvider.pickupAddress,
                      lat: homeProvider.pickupLocation!.latitude,
                      lon: homeProvider.pickupLocation!.longitude,
                    );
                    homeProvider.selectDestination(currentPlace);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.my_location,
                          color: Colors.blue,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Use current location",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Divider(height: 16, thickness: 1),

              // ✅ Section title: "Recent Places" or "Suggested Places"
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    Text(
                      homeProvider.desinationController.text.isEmpty
                          ? "Recent Places"
                          : "Suggested Places",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              /// LOADING STATE — shimmer animation while fetching
              // ✅ NEW: Shows skeleton placeholders while API is loading
              if (homeProvider.isSearching) ...[
                Expanded(child: _ShimmerList()),
              ]

              /// EMPTY STATE — no results found
              // ✅ NEW: Shows friendly empty state instead of blank screen
              else if (homeProvider.destinationSuggestions.isEmpty &&
                  homeProvider.desinationController.text.isNotEmpty) ...[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 48,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "No places found",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Try a different search term",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ]

              /// SUGGESTIONS LIST
              else ...[
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: homeProvider.destinationSuggestions.length,
                    itemBuilder: (context, index) {
                      final place =
                          homeProvider.destinationSuggestions[index];

                      // ✅ NEW: Split display name for 2-line display
                      // e.g. "Sindhi Camp, Jaipur, Rajasthan, India"
                      // → title: "Sindhi Camp"  subtitle: "Jaipur, Rajasthan"
                      final parts = place.displayName.split(', ');
                      final title = parts.isNotEmpty ? parts[0] : place.displayName;
                      final subtitle = parts.length > 1
                          ? parts.sublist(1).take(2).join(', ')
                          : '';

                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: place.isRecent
                                ? Colors.grey.shade100 // grey for recent
                                : AppColor.primaryYellow
                                    .withOpacity(0.15), // yellow for search
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // ✅ FIX: Different icon for recent vs live search results
                          child: Icon(
                            place.isRecent
                                ? Icons.history       // 🕐 clock for recent
                                : Icons.location_on, // 📍 pin for search
                            color: place.isRecent
                                ? Colors.grey.shade600
                                : AppColor.primaryYellow,
                            size: 20,
                          ),
                        ),
                        // ✅ NEW: Two-line display — clean title + muted subtitle
                        title: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: subtitle.isNotEmpty
                            ? Text(
                                subtitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                ),
                              )
                            : null,

                        onTap: () async {
                          // ✅ Hide keyboard on tap
                          FocusScope.of(context).unfocus();

                          homeProvider.selectDestination(place);

                          // ✅ Show loading while fetching ride estimate
                          final result = await homeProvider.getAllEstimtedData(
                            pickupAddress: homeProvider.pickupAddress,
                            pickupLat:
                                homeProvider.pickupLocation?.latitude ?? 0.0,
                            pickupLng:
                                homeProvider.pickupLocation?.longitude ?? 0.0,
                            dropAddress:
                                homeProvider.desinationController.text,
                            dropLat:
                                homeProvider.destinationLocation?.latitude ??
                                26.9126,
                            dropLng:
                                homeProvider.destinationLocation?.longitude ??
                                75.7441,
                          );

                          if (result.success) {
                            homeProvider.goToRideSelection();
                          } else {
                            // ✅ NEW: Show error snackbar if estimate fails
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    result.message ?? "Could not get estimate",
                                  ),
                                  backgroundColor: Colors.red.shade400,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ],

              // ✅ NEW: Full-screen loading overlay when estimate API is running
              if (homeProvider.loading)
                Positioned.fill(
                  child: Container(
                    color: Colors.white.withOpacity(0.7),
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text(
                            "Finding best rides...",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

// ✅ NEW: Shimmer skeleton loader for suggestions list
class _ShimmerList extends StatefulWidget {
  @override
  State<_ShimmerList> createState() => _ShimmerListState();
}

class _ShimmerListState extends State<_ShimmerList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ListView.builder(
          itemCount: 5,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  // Icon placeholder
                  Opacity(
                    opacity: _animation.value,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title placeholder
                        Opacity(
                          opacity: _animation.value,
                          child: Container(
                            height: 14,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Subtitle placeholder
                        Opacity(
                          opacity: _animation.value,
                          child: Container(
                            height: 11,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// ✅ NEW: Custom painter for dashed vertical line between pickup & destination dots
class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 1.5;

    double y = 0;
    const dashHeight = 3.0;
    const dashSpace = 3.0;

    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(0, y + dashHeight), paint);
      y += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) => false;
}