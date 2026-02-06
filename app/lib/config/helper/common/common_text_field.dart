import 'package:app/config/colors/app_color.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;
  final String? value;

  const CommonTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        fillColor: AppColor.lightyellow,
        hintText: hintText,
        border:  OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.darkYellow)
        ),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.darkYellow)),
        
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColor.darkYellow)),
      ),
    );
  }
}