import 'package:flutter/material.dart';
import 'package:store_web/generated/l10n.dart';
import 'package:flutter/services.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback? onPressed;
  final String content;
  final String? title;
  final String? primaryButton;
  final bool forceQuit;
  const CustomAlertDialog(
      {super.key, required this.onPressed,
      this.forceQuit = false,
      this.primaryButton,
      required this.content,
      this.title});

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
                onPressed: onPressed,
                child: Text(primaryButton ?? S.current.confirm)),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (forceQuit) {
                  SystemNavigator.pop();
                }
              },
              child: Text(S.current.cancel)),
        ],
      ),
    );
  }
}
