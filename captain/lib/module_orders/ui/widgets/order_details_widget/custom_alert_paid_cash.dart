import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomAlertDialogForCash extends StatelessWidget {
  final Function(bool) onPressed;
  final String content;
  final String? title;
  const CustomAlertDialogForCash(
      {required this.onPressed, required this.content, this.title});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 750),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.bounceIn,
      builder: (context, double val, child) {
        return Transform.scale(
          scale: val,
          child: child,
        );
      },
      child: AlertDialog(
        title: Text(title ?? S.current.warnning),
        content: Container(child: Text(content)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        actionsAlignment: onPressed == null ? MainAxisAlignment.center : null,
        actions: [
          Visibility(
              visible: onPressed != null,
              child: TextButton(
                  onPressed: onPressed(true), child: Text(S.current.yes))),
          TextButton(
              onPressed: () {
                onPressed(false);
              },
              child: Text(S.current.no)),
        ],
      ),
    );
  }
}
