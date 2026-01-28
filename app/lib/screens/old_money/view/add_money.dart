import 'package:app/config/helper/common/top_snacbar.dart';
import 'package:app/screens/old_money/view_model/ola_money_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddMoney extends StatelessWidget {
  const AddMoney({super.key});

  final String upiId = "adminupi@bank";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Money"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<OlaMoneyProvider>(
          builder: (BuildContext context, controller, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// QR Scanner placeholder
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            controller.adminUpiDetails?.upi?.qrCode ?? "",
                          ),
                        ),
                        SizedBox(height: 8),
                        Text("Scan QR to Pay"),
                        SizedBox(height: 4),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// UPI ID with copy icon
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.adminUpiDetails?.upi?.upiId ??
                                "not found",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: upiId));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("UPI ID copied")),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Amount
                  const Text("Amount"),
                  const SizedBox(height: 6),
                  TextField(
                    controller: controller.amountController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration("Enter amount"),
                  ),

                  const SizedBox(height: 16),

                  /// Transaction ID
                  const Text("Transaction ID"),
                  const SizedBox(height: 6),
                  TextField(
                    controller: controller.transectionIdController,
                    decoration: _inputDecoration("Enter transaction ID"),
                  ),

                  const SizedBox(height: 16),

                  /// UPI / Mobile number
                  const Text("UPI ID / Mobile Number"),
                  const SizedBox(height: 6),
                  TextField(
                    controller: controller.upiIdController,
                    decoration: _inputDecoration(
                      "Enter UPI ID or mobile number",
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// notes
                  const Text("Notes"),
                  const SizedBox(height: 6),
                  TextField(
                    controller: controller.noteController,
                    decoration: _inputDecoration("note"),
                  ),

                  const SizedBox(height: 30),

                  /// Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () async {
                        // API call later
                        final result = await controller.walletRecharge();

                        if (result.success) {
                          AppSnackBar.show(context, message: result.message);
                        } else {
                          AppSnackBar.show(context, message: result.message);
                        }
                      },
                      child: const Text("Add Money"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      isDense: true,
    );
  }
}
