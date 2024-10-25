import 'package:flutter/material.dart';
import 'package:riverpodtest/core/pallete.dart';

class AppTheme {
  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: _textFieldDecoration(Pallete.borderColor),
      focusedBorder: _textFieldDecoration(Pallete.gradient2),
    ),
  );

  static _textFieldDecoration(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
        borderRadius: BorderRadius.circular(8));
  }
}
