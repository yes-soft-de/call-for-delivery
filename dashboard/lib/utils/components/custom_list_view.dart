import 'package:flutter/material.dart';

class CustomListView {
  static dynamic custom(
      {required List<Widget> children,
      EdgeInsetsGeometry? padding,
      ScrollController? controller}) {
    return ListView(
      controller: controller,
      padding: padding,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: children,
    );
  }

  static dynamic customGrid(
      {required List<Widget> children,
        EdgeInsetsGeometry? padding,
        ScrollController? controller}) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      controller: controller,
      padding: padding,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: children,
      childAspectRatio:10/11,
    );
  }
}
