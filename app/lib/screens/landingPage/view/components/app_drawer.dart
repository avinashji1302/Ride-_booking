import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/About/view/about_screen.dart';
import 'package:app/screens/Auth/View/signIn/sign_in_page.dart';
import 'package:app/screens/address/view/address.dart';
import 'package:app/screens/faq/view/faq_screen.dart';
import 'package:app/screens/help/view/help.dart';
import 'package:app/screens/history/view/history_screen.dart';
import 'package:app/screens/notification/view/notfication_screen.dart';
import 'package:app/screens/notification/viewmodel/notification_provider.dart';
import 'package:app/screens/ola_money/view/ola_money.dart';
import 'package:app/screens/ola_money/view_model/ola_money_provider.dart';
import 'package:app/screens/profile/view/user_profile.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final oldMoneyProvider = context.watch<OlaMoneyProvider>();

    return Drawer(
      backgroundColor: Colors.white,
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return SafeArea(
            child: Column(
              children: [
                /// ================= HEADER =================
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColor.primaryYellow,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileProvider.userDetails?.fullName ??
                                  "User Name",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profileProvider.userDetails?.email ??
                                  "Email not found",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(),

                /// ================= MENU =================
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: [
                      _sectionTitle("Account"),

                      _drawerTile(
                        icon: Icons.person,
                        title: "Profile",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const UserProfile(),
                            ),
                          );
                        },
                      ),

                      _drawerTile(
                        icon: Icons.history,
                        title: "History",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaymentHistoryScreen(),
                            ),
                          );
                        },
                      ),

                      _drawerTile(
                        icon: Icons.currency_rupee,
                        title: "Ola Money",
                        onTap: () async {
                          // final response = await profileProvider.getProfile();

                          // final olaResponseData = await oldMoneyProvider
                          //     .olaMoneyPayHistoryStatus();

                          // debugPrint("ola response : ${olaResponseData.data}");

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => OlaMoney()),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      _sectionTitle("Support"),

                      _drawerTile(
                        icon: Icons.info_outline,
                        title: "About",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AboutScreen()),
                          );
                        },
                      ),

                      _drawerTile(
                        icon: Icons.question_answer_outlined,
                        title: "FAQ",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => FaqScreen()),
                          );
                        },
                      ),

                      _drawerTile(
                        icon: Icons.support_agent,
                        title: "Help",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => HelpScreen()),
                          );
                        },
                      ),

                      _drawerTile(
                        icon: Icons.location_city,
                        title: "Address",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AddressScreen()),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      /// ================= NOTIFICATION =================
                      Consumer<NotificationProvider>(
                        builder: (context, provider, _) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              leading: Icon(
                                provider.isEnable
                                    ? Icons.notifications_active
                                    : Icons.notifications_off,
                              ),
                              title: const Text("Notifications"),

                              trailing: Switch(
                                value: provider.isEnable,
                                activeColor: Colors.green,
                                onChanged: (value) {
                                  provider.seenNotification(value);
                                },
                              ),

                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => NotificationScreen(),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                /// ================= LOGOUT =================
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: Colors.red.shade50,
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () async {
                      final response = await profileProvider.logout();

                      if (response.success) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => SignInPage()),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }

  /// ================= COMMON TILE =================
  Widget _drawerTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  /// ================= SECTION TITLE =================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontSize: 13,
        ),
      ),
    );
  }
}
