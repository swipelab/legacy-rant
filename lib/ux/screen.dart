import 'dart:ui';

import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final Widget top;
  final Widget bottom;

  final Widget child;

  Screen({this.top, this.bottom, this.child});

  Widget sizedSliver({double height}) =>
      SliverList(delegate: SliverChildListDelegate([SizedBox(height: height)]));

  Widget blurred(Widget child) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaY: 16, sigmaX: 16), child: child));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(child: child),
        if (top != null)
          Positioned(top: 0, left: 0, right: 0, child: blurred(top)),
        if (bottom != null)
          Positioned(bottom: 0, left: 0, right: 0, child: blurred(bottom)),
      ],
    ));
  }
}
