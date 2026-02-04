import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/ola_money/view/add_money.dart';
import 'package:app/screens/ola_money/view_model/ola_money_provider.dart';
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
      backgroundColor: Colors.grey.shade100, // 🌤 soft background
      appBar: AppBar(
        title: const Text("Ola Money"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileController, _) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// ───── WALLET CARD
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryYellow.withOpacity(0.9),
                        AppColor.primaryYellow,
                      ],
                    ),
                  ),
                  child: Card(
                    elevation: 0,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          /// Balance Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Wallet Balance",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "₹${profileController.userDetails?.wallet ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),

                              olaMoneyProvider.isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : ElevatedButton(
                                      onPressed: () async {
                                        final result = await olaMoneyProvider
                                            .getAdminPayemnt();

                                        AppSnackBar.show(
                                          context,
                                          message: result.message,
                                        );

                                        if (result.success) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => AddMoney(),
                                            ),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            22,
                                          ),
                                        ),
                                      ),
                                      child: const Text("Add Money"),
                                    ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          Divider(
                            thickness: 1,
                            color: Colors.black.withOpacity(0.2),
                          ),

                          const SizedBox(height: 10),

                          /// Security Note
                          Row(
                            children: const [
                              Icon(
                                Icons.lock_outline,
                                size: 18,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Your Ola Money is safe and secure",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ───── QUICK ACTIONS
                Card(
                  color: Colors.white,
                  elevation: 1,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: AppColor.primaryYellow.withOpacity(0.4),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.history,
                          color: AppColor.primaryYellow,
                        ),
                        title: const Text(
                          "Transaction History",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                        onTap: () {},
                      ),
                      Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
                      ListTile(
                        leading: Icon(
                          Icons.info_outline,
                          color: AppColor.primaryYellow,
                        ),
                        title: const Text(
                          "Wallet Details",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: const Icon(
                          Icons.chevron_right,
                          color: Colors.grey,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ───── RECENT TRANSACTIONS
                Card(
                  elevation: 0.8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        olaMoneyProvider.olaPaymentStatusHistory?.data.length ??
                        0,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final data =
                          olaMoneyProvider.olaPaymentStatusHistory!.data[index];

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: data.status == "pending"
                              ? Colors.orange.shade100
                              : Colors.green.shade100,
                          child: Icon(
                            data.status == "pending"
                                ? Icons.hourglass_empty
                                : Icons.check,
                            color: data.status == "pending"
                                ? Colors.orange
                                : Colors.green,
                          ),
                        ),
                        title: Text(
                          "₹${data.amount}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        trailing: Text(
                          data.status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: data.status == "pending"
                                ? Colors.orange
                                : Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

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
