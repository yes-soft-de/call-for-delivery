import 'package:flutter/material.dart';
import 'package:store_web/utils/components/faded_button_bar.dart';

class StackedForm extends StatelessWidget {
  final Widget child;
  final String label;
  final VoidCallback onTap;
  final bool visible;
  const StackedForm(
      {super.key, required this.child,
      required this.label,
      required this.onTap,
      this.visible = true});

  @override
  Widget build(BuildContext context) {
    if (visible) {
      return Stack(
        children: [
          child,
          Align(
              alignment: Alignment.bottomCenter,
              child: FadedButtonBar(onPressed: onTap, text: label)),
        ],
      );
    }
    return child;
  }
}
