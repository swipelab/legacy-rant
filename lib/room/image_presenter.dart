import 'package:flutter/material.dart';
import 'package:rant/matrix/matrix.dart';
import 'package:rant/matrix/types/mx_event.dart';
import 'package:rant/matrix/types/mx_image.dart';

class ImagePresenter extends StatelessWidget {
  final MxEvent event;
  final MxImage image;

  ImagePresenter(this.event) : image = event.content as MxImage;

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-1, -1),
      child: Container(
        decoration: BoxDecoration(),
        width: 128,
        height: 128,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(Matrix.mxcToUrl(image.url), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
