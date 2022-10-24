import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomFlushBarHelper {
  static Widget warningDialog({
    required String title,
    required String message,
    required BuildContext context,
  }) {
    return AlertDialog(
      title: Text(title),
      scrollable: true,
      content: Container(child: Text(message)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            Widget: Text(S.current.cancel))
      ],
    );
  }

  static Flushbar createSuccess(
      {required String title,
      required String message,
      int timeout = 4,
      Color? background,
      bool top = false,
      EdgeInsets? padding,
      EdgeInsets? margin}) {
    return Flushbar(
      maxWidth: 600,
      title: title,
      message: message,
      icon: const Icon(
        Icons.info,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundColor: background ?? Colors.green,
      duration: Duration(seconds: timeout),
      borderRadius: BorderRadius.circular(25),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: margin ?? const EdgeInsets.all(8),
      padding: padding ?? const EdgeInsets.all(16),
      flushbarPosition: top ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    );
  }

  static Flushbar createError(
      {required String title, required String message, int timeout = 4}) {
    return Flushbar(
      maxWidth: 600,
      title: title,
      message: message,
      icon: const Icon(
        Icons.info,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: timeout),
      borderRadius: BorderRadius.circular(25),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(8),
    );
  }
}
