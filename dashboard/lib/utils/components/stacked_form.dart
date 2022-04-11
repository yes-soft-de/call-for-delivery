import 'package:flutter/material.dart';
import 'package:c4d/utils/components/faded_button_bar.dart';

class StackedForm extends StatelessWidget {
  final Widget child;
  final String label;
  final VoidCallback onTap;
  final bool visible;
  StackedForm(
      {required this.child,
      required this.label,
      required this.onTap,
      this.visible = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Visibility(
          visible: visible,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: FadedButtonBar(
                onPressed: onTap,
                text: label,
              )),
        ),
      ],
    );
  }
}
