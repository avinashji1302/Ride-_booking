import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/profile/view/update_profile.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();

    /// fetch profile AFTER screen opens
    Future.microtask(() {
      context.read<ProfileProvider>().getProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          final user = profileProvider.userDetails;

          if (profileProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (user == null) {
            return const Center(child: Text("Unable to load profile"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ---------------- PROFILE IMAGE ----------------
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 46,
                      backgroundColor: AppColor.grey.withOpacity(0.2),
                      backgroundImage: user.profilePic.isNotEmpty
                          ? NetworkImage(user.profilePic)
                          : null,
                      child: user.profilePic.isEmpty
                          ? CircleAvatar(
                              radius: 44,
                              backgroundColor: AppColor.lightyellow,
                              child: const Icon(
                                Icons.person,
                                size: 42,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: InkWell(
                        onTap: () {

                          debugPrint("data is : ${user.firstName} ${user.address[0]} ${user.profilePic}}");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => 
                              
                              
                              UpdateProfile(
                                fullName: user.fullName,
                                profilePic: user.profilePic,
                                address: "Address",
                              ),



                            ),
                          );
                        },
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.grey.withOpacity(0.4),
                            ),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 14,
                            color: AppColor.primaryYellow,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ---------------- NAME ----------------
                Text(
                  user.fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                // ---------------- MOBILE ----------------
                Text(
                  user.mobile,
                  style: TextStyle(color: Colors.grey.shade600),
                ),

                const SizedBox(height: 24),

                // ---------------- WALLET ----------------
                Card(
                 color: Colors.white,
                  elevation: 1,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: AppColor.primaryYellow.withOpacity(0.4),
                    ),),
                  child: ListTile(
                    leading: const Icon(Icons.account_balance_wallet , color: AppColor.primaryYellow,),
                    title: const Text("Wallet Balance"),
                    trailing: Text(
                      "₹ ${user.wallet}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ---------------- OPTIONS ----------------
                Card(
                 color: Colors.white,
                  elevation: 1,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: AppColor.primaryYellow.withOpacity(0.4),
                    ),),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.history , color: AppColor.primaryYellow,),
                        title: const Text("Ride History"),
                        onTap: () {},
                      ),
                       Divider(height: 1 ,    color: AppColor.primaryYellow.withOpacity(0.4)),
                      ListTile(
                        leading: const Icon(Icons.settings , color: AppColor.primaryYellow,),
                        title: const Text("Settings"),
                        onTap: () {},
                      ),
                       Divider(height: 1 ,    color: AppColor.primaryYellow.withOpacity(0.4)),
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text(
                          "Logout",
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {},
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
