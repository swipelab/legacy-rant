import 'package:flutter/material.dart';

mixin PostFrame<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => postFirstFrame());
  }

  void postFirstFrame();
}
