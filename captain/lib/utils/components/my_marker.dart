import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';

class MyMarker extends StatelessWidget {
  // declare a global key and get it trough Constructor

  MyMarker(this.globalKeyMyWidget);
  final GlobalKey globalKeyMyWidget;

  @override
  Widget build(BuildContext context) {
    // wrap your widget with RepaintBoundary and
    // pass your global key to RepaintBoundary
    return RepaintBoundary(
        key: globalKeyMyWidget,
        child: Image.asset(
          ImageAsset.ARAB_LANGUAGE,
          height: 125,
          width: 125,
        ));
  }
}
