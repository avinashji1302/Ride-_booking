import 'package:app/config/colors/app_color.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final String? value;
      bool? autoFocus = false;

   CommonTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.value,
    this.autoFocus
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
       autofocus: autoFocus??false,
      // decoration: InputDecoration(
      //   fillColor: AppColor.lightyellow,
      //   hintText: hintText,
      //   border:  OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(10.0),
      //     borderSide: BorderSide(color: AppColor.darkYellow)
      //   ),
      //   enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.darkYellow)),
        
      //       focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.darkYellow)),
      // ),

       decoration: InputDecoration(
          // prefixIcon: Icon(icon, color: iconColor, size: 20),
          hintText: hintText,
          isDense: true, 
          contentPadding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
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
    );
  }
}