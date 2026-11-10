import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Enables horizontal carousel drag on touch, mouse, and trackpad.
class HorizontalCarouselScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
