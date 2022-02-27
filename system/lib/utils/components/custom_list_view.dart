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
      shrinkWrap: true,
      crossAxisCount: 2,
      controller: controller,
      padding: padding,
      childAspectRatio: 5/4,
      physics: BouncingScrollPhysics(parent: NeverScrollableScrollPhysics()),
      children: children,
    );
  }
}
