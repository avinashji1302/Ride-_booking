import 'package:app/config/colors/app_color.dart';
import 'package:app/config/helper/common/common_button.dart';
import 'package:app/config/helper/common/common_text_field.dart';
import 'package:app/config/helper/common/top_snacbar.dart';

import 'package:app/screens/ola_money/view_model/ola_money_provider.dart';
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
      body: SafeArea(
        child: Padding(
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
                        border: Border.all(color: AppColor.primaryYellow),
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
                 
        
                    // InputFieldWidget(hint: "Enter amout", controller: controller.amountController,),
                    CommonTextField(
                      hintText: 'Enter amout',
                      controller: controller.amountController,
                    ),
        
                    const SizedBox(height: 16),
        
                    /// Transaction ID
                    const Text("Transaction ID"),
                    const SizedBox(height: 6),
        
                   
                    CommonTextField(
                      hintText: "Enter Transectin Id",
                      controller: controller.transectionIdController,
                    ),
        
                    const SizedBox(height: 16),
        
                    /// UPI / Mobile number
                    const Text("UPI ID / Mobile Number"),
                    const SizedBox(height: 6),
        
                   
                    CommonTextField(
                      hintText: "UPI ID / Mobile Number",
                      controller: controller.upiIdController,
                    ),
        
                    const SizedBox(height: 6),
        
                    /// notes
                    const Text("Notes"),
                    const SizedBox(height: 6),
        
                   
                    CommonTextField(
                      hintText: "Enter your notes",
                      controller: controller.noteController,
                    ),
        
                    const SizedBox(height: 30),
        
                 
                    CommonButton(
                      title: "Add Money",
                      onPressed: () async {
                        // API call later
                        final result = await controller.walletRecharge();
        
                        if (result.success) {
                          AppSnackBar.show(context, message: result.message);
                          Navigator.pop(context, true);
                        } else {
                          AppSnackBar.show(context, message: result.message);
                        }
                      },
                      backgroundColor: AppColor.primaryYellow,
                    ),

                  
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }


}
