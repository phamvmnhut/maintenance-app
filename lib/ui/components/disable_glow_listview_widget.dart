
import 'package:flutter/material.dart';

class DisableGlowListViewWidget extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
