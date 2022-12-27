import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onPressed2;
  final String content;
  final String? title;
  final String? actionTitle;
  final String? actionTitle2;
  final bool oneAction;
  CustomAlertDialog(
      {required this.onPressed,
      required this.content,
      this.title,
      required this.oneAction,
      this.onPressed2,
      this.actionTitle,
      this.actionTitle2});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 750),
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
        actions: [
          TextButton(
              onPressed: onPressed,
              child: oneAction
                  ? Text(S.current.ok)
                  : Text(actionTitle ?? S.current.confirm)),
          oneAction
              ? Container()
              : TextButton(
                  onPressed: onPressed2 ??
                      () {
                        Navigator.of(context).pop();
                      },
                  child: Text(actionTitle2 ?? S.current.cancel)),
        ],
      ),
    );
  }
}
