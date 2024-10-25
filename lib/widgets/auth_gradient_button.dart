import 'package:flutter/material.dart';
import 'package:riverpodtest/core/pallete.dart';

class AuthGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const AuthGradientButton(
      {super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Pallete.gradient1, Pallete.gradient2]),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.transparentColor,
            shadowColor: Pallete.transparentColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        ));
  }
}
