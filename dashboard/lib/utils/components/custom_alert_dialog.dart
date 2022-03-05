import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';

class CustomAlertDialog extends StatelessWidget {
  final VoidCallback? onPressed;
  final String content;
  final String? title;
  final bool oneAction;
  CustomAlertDialog(
      {required this.onPressed, required this.content, this.title,required this.oneAction});

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
          TextButton(onPressed: onPressed, child:oneAction ? Text(S.current.ok): Text(S.current.confirm)),
        oneAction?Container():  TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.current.cancel)),
        ],
      ),
    );
  }
}
