import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/home/view/home_page.dart';
import 'package:app/screens/landingPage/view/search_ride_screen.dart';
import 'package:app/screens/landingPage/viewModel/landing_provider.dart';
import 'package:app/screens/notification/view/notfication_screen.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  @override
  Widget build(BuildContext context) {
    final profile = context.watch<ProfileProvider>();
    final landing = context.watch<LandingProvider>();

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Logo row ──
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  landing.scaffoldKey.currentState?.openDrawer();
                },
                child: Card(
                  shape: const CircleBorder(),
                  color: AppColor.lightyellow,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Icon(Icons.menu),
                  ),
                ),
              ),

              // Container(
              //   width: 34,
              //   height: 34,
              //   decoration: BoxDecoration(
              //     color: AppColor.primaryYellow,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: const Icon(
              //     Icons.electric_bolt_rounded,
              //     size: 18,
              //     color: Color(0xFF1a1a2e),
              //   ),
              // ),
              const SizedBox(width: 20),
              const Text(
                "ZipRide",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1a1a2e),
                  letterSpacing: -0.4,
                ),
              ),
              const Spacer(),
              // Notification bell
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F4F4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: Color(0xFF555555),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // ── Greeting ──
          Text(
            "Good morning, ${profile.userDetails?.fullName?.split(' ').first ?? 'there'} 👋",
            style: const TextStyle(fontSize: 13, color: Color(0xFF888888)),
          ),
          const SizedBox(height: 6),
          const Text(
            "Where are you\nheaded today?",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1a1a2e),
              height: 1.25,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 22),

          // ── Search bar (tappable, navigates to HomePage) ──
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => const HomePage()),
              // );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchRideScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE0E0E0)),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchRideScreen()),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.search_rounded,
                      color: Color(0xFFAAAAAA),
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "Enter destination...",
                        style: TextStyle(
                          color: Color(0xFFAAAAAA),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primaryYellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Go",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1a1a2e),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
