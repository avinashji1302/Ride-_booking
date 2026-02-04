import 'package:app/config/colors/app_color.dart';
import 'package:flutter/material.dart';

class LocationTextField extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String hint;
  final String value;

  const LocationTextField({
    required this.icon,
    required this.iconColor,
    required this.hint,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44, 
      child: TextField(
        readOnly: true,
        controller: TextEditingController(text: value),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: iconColor, size: 20),
          hintText: hint,
          isDense: true, 
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.primaryYellow, 
              width: 1.2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColor.primaryYellow,
              width: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

