import 'package:app/config/colors/app_color.dart';
import 'package:flutter/material.dart';


class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  static const String appName = "Waplia Tech";
  static const String version = "1.0.0";
  static const String company = "Waplia Pvt. Ltd.";
  static const String email = "support@waplia.com";
  static const String website = "www.waplia.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About..."),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// App Logo + Name
            const SizedBox(height: 30),

            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: AppColor.primaryYellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.local_taxi,
                color: Colors.white,
                size: 50,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              appName,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Version $version",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            /// Description
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Your App is a reliable ride-hailing platform designed to provide safe, fast, and affordable rides. "
                "We connect riders with nearby drivers using real-time technology to ensure a seamless travel experience.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Info Cards
            _buildTile(
              icon: Icons.business,
              title: "Company",
              value: company,
            ),

            _buildTile(
              icon: Icons.email,
              title: "Support Email",
              value: email,
            ),

            _buildTile(
              icon: Icons.language,
              title: "Website",
              value: website,
            ),

           

            _buildTile(
              icon: Icons.description,
              title: "Terms & Conditions",
              value: "View Terms",
            ),

            const SizedBox(height: 30),

            /// Footer
            const Text(
              "© 2026 Your Company Pvt. Ltd.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _buildTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primaryYellow),
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }
}
