import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const uiNameIdentifier = "JWPayerView";

class JWPlayerView extends StatelessWidget {
  final Map<String, dynamic> creationParams;
  const JWPlayerView({super.key, required this.creationParams});

  @override
  Widget build(BuildContext context) {
    return UiKitView(
      viewType: uiNameIdentifier,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
