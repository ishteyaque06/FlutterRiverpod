import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformIndicator {
  Color color();
  Widget build();
  factory PlatformIndicator(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
        return AndroidIndicator();
      case TargetPlatform.iOS:
        return IOSIndicator();
      default:
        return IOSIndicator();
    }
  }
}

class AndroidIndicator implements PlatformIndicator {
  @override
  Widget build() {
    // TODO: implement build
    return CircularProgressIndicator();
  }

  @override
  Color color() {
    // TODO: implement color
    return Colors.blue;
  }
}

class IOSIndicator implements PlatformIndicator {
  @override
  Widget build() {
    // TODO: implement build
    return CupertinoActivityIndicator();
  }

  @override
  Color color() {
    // TODO: implement color
    return Colors.blue;
  }
}
