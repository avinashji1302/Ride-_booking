import 'package:app/config/colors/app_color.dart';

import 'package:flutter/material.dart';

void showCommonStatusDialog({
  required BuildContext context,
  required IconData icon,
  required String title,
  required String message,
  Color iconBgColor = Colors.green,
  Color buttonColor = AppColor.primaryYellow,
  String buttonText = "OK",
  VoidCallback? onPressed,
  bool barrierDismissible = false,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// ICON
             Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              // ScallopedStatusIcon(
              //   size: 20,
              //   backgroundColor: Colors.green.shade100,
              //   icon: icon,
              //   iconColor: Colors.green,
              // ),

              const SizedBox(height: 16),

              /// TITLE
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              /// MESSAGE
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 20),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: onPressed ?? () => Navigator.pop(context),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColor.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
