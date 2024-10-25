import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  const CustomField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscure = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        validator: (val) {
          if (val!.trim().isEmpty) {
            return "$hintText can not be emply";
          }
          return null;
        },
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
