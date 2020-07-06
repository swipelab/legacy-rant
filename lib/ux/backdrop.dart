import 'dart:ui';
import 'package:flutter/cupertino.dart';

class Backdrop extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;

  Backdrop({this.child, this.sigmaX = 16, this.sigmaY = 16});

  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: sigmaY,
              sigmaX: sigmaX,
            ),
            child: child));
  }
}
