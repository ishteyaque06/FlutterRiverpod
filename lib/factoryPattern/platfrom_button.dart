import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatfromButton {
  Widget build(VoidCallback onPressed, Widget child);
  factory PlatfromButton(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidButton();
      case TargetPlatform.iOS:
        return IOSButton();
      default:
        return IOSButton();
    }
  }
}

class AndroidButton implements PlatfromButton {
  @override
  Widget build(VoidCallback onPressed, Widget child) {
    // TODO: implement build
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}

class IOSButton implements PlatfromButton {
  @override
  Widget build(VoidCallback onPressed, Widget child) {
    // TODO: implement build
    return CupertinoButton.filled(child: child, onPressed: onPressed);
  }
}
