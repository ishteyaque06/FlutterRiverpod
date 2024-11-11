import 'package:flutter/material.dart';
import 'package:riverpodtest/factoryPattern/platform_indicator.dart';
import 'package:riverpodtest/factoryPattern/platfrom_button.dart';

abstract class PlatformWidgetFactory {
  Widget buildButton(
      BuildContext context, VoidCallback onPressed, Widget child);
  Widget buildIndicator(BuildContext context);
}

class PlatformWidgetFactoryImp implements PlatformWidgetFactory {
  @override
  Widget buildButton(
      BuildContext context, VoidCallback onPressed, Widget child) {
    // TODO: implement buildButton
    return PlatfromButton(Theme.of(context).platform).build(onPressed, child);
  }

  @override
  Widget buildIndicator(BuildContext context) {
    // TODO: implement buildIndicator
    return PlatformIndicator(Theme.of(context).platform).build();
  }
}
