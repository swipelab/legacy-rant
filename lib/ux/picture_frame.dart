import 'package:flutter/material.dart';

class Picture extends StatelessWidget {
  final String url;

  Picture(this.url);

  Widget build(BuildContext context) {
    return url == null
        ? Container()
        : Image.network(
            url,
            filterQuality: FilterQuality.high,
          );
  }
}

class PictureFrame extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final BorderRadius borderRadius;
  final Border border;
  final Color color;
  final EdgeInsets padding;

  PictureFrame({
    this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.border,
    this.color,
    this.padding,
  });

  factory PictureFrame.circular({
    Widget child,
    double radius = 12,
    double size = 48,
    double borderThickness = 2,
  }) {
    return PictureFrame(
        padding: EdgeInsets.all(1),
        child: child,
        width: size,
        height: size,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.fromBorderSide(
            BorderSide(color: Colors.white, width: borderThickness)),
        color: Color(0xFFAAAAAA));
  }

  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              spreadRadius: 0,
              offset: Offset.zero)
        ],
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: borderRadius,
        border: border,
      ),
      child: ClipRRect(
          borderRadius: borderRadius,
          child: Container(color: color, child: child)),
    );
  }
}
