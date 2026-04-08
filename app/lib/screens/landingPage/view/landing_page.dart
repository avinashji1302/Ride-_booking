import 'package:app/screens/landingPage/view/components/app_drawer.dart';
import 'package:app/screens/landingPage/view/components/category_screen.dart';
import 'package:app/screens/landingPage/view/components/hero_section.dart';
import 'package:app/screens/landingPage/view/components/offer_banner.dart';
import 'package:app/screens/landingPage/viewModel/landing_provider.dart';
import 'package:app/screens/profile/view/user_profile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/view/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final landingProvider = context.watch<LandingProvider>();

    return Scaffold(
      key: landingProvider.scaffoldKey,
      drawer: const AppDrawer(),
      backgroundColor: Colors.white,

      /// 🔥 KEEP SCREENS ALIVE
      body: SafeArea(
        child: IndexedStack(
          index: landingProvider.index,
          children: const [
            LandingHomeScreen(),
            HomePage(),
            UserProfile(),
          ],
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              currentIndex: landingProvider.index,
              onTap: landingProvider.changeBottemNav,

              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              elevation: 0,

              selectedItemColor: Colors.amber,
              unselectedItemColor: Colors.grey,

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: "Home",
                ),
                BottomNavigationBarItem(icon: Icon(Icons.map), label: "Ride"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LandingHomeScreen extends StatefulWidget {
  const LandingHomeScreen({super.key});

  @override
  State<LandingHomeScreen> createState() => _LandingHomeScreenState();
}

class _LandingHomeScreenState extends State<LandingHomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<LandingProvider>().loadProfile(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          HeroSection(),
          SizedBox(height: 16),
          OfferBanner(),
          SizedBox(height: 20),
          RideCategorySection(),
        ],
      ),
    );
  }
}

