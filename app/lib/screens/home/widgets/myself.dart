import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/widgets/cylinder_line.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  /// Dummy static data
  static const String name = "Avinash Sharma";
  static const String phone = "+91 9876543210";
  static const String email = "avinash@email.com";
  static const String userId = "USR102938";
  static const String memberSince = "Feb 2026";

  @override
  Widget build(BuildContext context) {
    final data = context.watch<ProfileProvider>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cylinderLine(),
        SizedBox(height: 10),

        /// Title
        Center(
          child: const Text(
            "Profile",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Divider(),
        const SizedBox(height: 16),

        /// User icon + name
        Row(
          children: [
            const CircleAvatar(
              radius: 30,

              backgroundColor: AppColor.primaryYellow,
              child: Icon(Icons.person, color: Colors.black, size: 30),
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text(
                  data.userDetails?.fullName??"Name not found",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4),
                Text("ID: ${data.userDetails?.id}", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),

        const SizedBox(height: 20),

        const Divider(),

        /// Phone
        _infoTile(icon: Icons.phone, title: "Phone", value: data.userDetails?.mobile??"63889878767"),

        /// Email
        _infoTile(icon: Icons.email, title: "Email",value: data.userDetails?.email??"avi@gmail.com"),

        /// Member since
        _infoTile(
          icon: Icons.calendar_today,
          title: "Member Since",
          value: memberSince,
        ),

        const SizedBox(height: 20),

        /// Logout button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ),
      ],
    );
  }

  static Widget _infoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColor.primaryYellow),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}
