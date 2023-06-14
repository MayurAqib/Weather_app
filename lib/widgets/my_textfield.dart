import 'package:flutter/material.dart';
import 'package:weather_app_using_rest_api/theme/colors.dart';

class MyTextfield extends StatelessWidget {
  const MyTextfield({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextField(
      cursorColor: Colors.grey.shade400,
      style: const TextStyle(color: Colors.white),
      controller: controller,
      decoration: const InputDecoration(
          hintText: 'Eg. Mohali',
          hintStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: designColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(8), right: Radius.circular(8)),
              borderSide: BorderSide.none)),
    ));
  }
}
