import 'package:flutter/material.dart';

class CustomListView {
  static dynamic custom(
      {required List<Widget> children,
      EdgeInsetsGeometry? padding,
      ScrollController? controller}) {
    return ListView(
      controller: controller,
      padding: padding,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: children,
    );
  }
}
