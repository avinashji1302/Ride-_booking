import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/common_button.dart';
import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/home/viewmodel/home_provider.dart';
import 'package:app/screens/profile/viewmodel/logout_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class PaymentMode extends StatefulWidget {
  final Function(String) onSubmit;

  const PaymentMode({super.key, required this.onSubmit});

  @override
  State<PaymentMode> createState() => _PaymentModeState();
}

class _PaymentModeState extends State<PaymentMode> {
  String selectedMethod = "Cash"; // default

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileProvider>();
    final homeProvider = context.read<HomeProvider>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Payment Mode",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        _paymentTile("Cash", profile, homeProvider),
        const Divider(height: 1),
        _paymentTile("Wallet", profile, homeProvider),

        const SizedBox(height: 20),

        CommonButton(
          title: "Continue",
          backgroundColor: AppColor.primaryYellow,
          onPressed: () {
            widget.onSubmit(selectedMethod);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _paymentTile(
    String title,
    ProfileProvider profile,
    HomeProvider homeProvider,
  ) {
    final isSelected = selectedMethod == title;

    return ListTile(
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: isSelected ? Colors.green : Colors.grey,
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: () {
        if (title == "Wallet" &&
            (profile.userDetails?.wallet ?? 0.0) <
                homeProvider.selectedVehiclePrice) {
          AppSnackBar.show(
            context,
            message: "You do not have enough balance...,  Please recharge",
          );

          return;
        }
        setState(() {
          selectedMethod = title;
        });
      },
    );
  }
}
