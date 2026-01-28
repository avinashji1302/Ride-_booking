import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/old_money/view/add_money.dart';
import 'package:app/screens/old_money/view_model/ola_money_provider.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class OlaMoney extends StatelessWidget {
  const OlaMoney({super.key});

  @override
  Widget build(BuildContext context) {
    final olaMoneyProvider = Provider.of<OlaMoneyProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(title: const Text("Ola Money"), centerTitle: true),
      body: Consumer<ProfileProvider>(
        builder: (BuildContext context, ProfileProvider profileController, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// ───── WALLET CARD
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        /// Balance Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  "Wallet Balance",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                            "₹${profileController.userDetails?.wallet.toString() }",
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            olaMoneyProvider.isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      final result = await olaMoneyProvider
                                          .getAdminPayemnt();

                                      if (result.success) {
                                        AppSnackBar.show(
                                          context,
                                          message: result.message,
                                        );
                                        Navigator.pop(context);
                                      } else {
                                        AppSnackBar.show(
                                          context,
                                          message: result.message,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text("Add Money"),
                                  ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        /// Divider
                        Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),

                        const SizedBox(height: 12),

                        /// Info Row
                        Row(
                          children: const [
                            Icon(
                              Icons.lock_outline,
                              size: 18,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Your Ola Money is safe and secure",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ───── QUICK ACTIONS
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.history),
                        title: const Text("Transaction History"),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                      Divider(height: 1),
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: const Text("Wallet Details"),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ───── FOOTER NOTE
                Text(
                  "Use Ola Money for faster and hassle-free rides",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
