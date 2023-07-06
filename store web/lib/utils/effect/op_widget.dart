import 'package:flutter/material.dart';

class OptionalWidget extends StatelessWidget {
  final Widget? widget;
  final Widget effectiveWidget;
  final bool effect;
  const OptionalWidget(
      {Key? key,
      required this.effect,
      required this.effectiveWidget,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (effect) {
      return effectiveWidget;
    } else if (widget != null) {
      return widget!;
    }
    return const SizedBox();
  }
}
