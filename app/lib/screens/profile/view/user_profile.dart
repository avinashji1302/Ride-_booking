import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileController, _) {
          final user = profileController.userDetails;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [

                /// ---------------- PROFILE HEADER ----------------
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey.shade300,
                  child:  Icon(
                          Icons.person,
                          size: 45,
                          color: Colors.white,
                        )
                     
                ),

                const SizedBox(height: 12),

                Text(
                  user?.firstName ?? "Guest User",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  user?.mobile ?? "Email not available",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 24),

                /// ---------------- WALLET CARD ----------------
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.account_balance_wallet),
                    title: const Text("Wallet Balance"),
                    trailing: Text(
                      "₹ ${user?.wallet ?? 0}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// ---------------- PROFILE OPTIONS ----------------
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [

                      ListTile(
                        leading: const Icon(Icons.history),
                        title: const Text("Ride History"),
                        onTap: () {
                          // navigate later
                        },
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text("Settings"),
                        onTap: () {},
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                         // profileController.logout(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
