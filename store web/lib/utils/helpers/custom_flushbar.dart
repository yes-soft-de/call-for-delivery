import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:store_web/utils/components/fixed_container.dart';

class CustomFlushBarHelper {
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
      backgroundGradient: LinearGradient(colors: [
        background?.withOpacity(0.7) ?? Colors.green[400]!,
        background?.withOpacity(0.8) ?? Colors.green,
        background?.withOpacity(0.9) ?? Colors.green[600]!,
        background ?? Colors.green[700]!,
      ]),
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
      backgroundGradient: LinearGradient(colors: [
        Colors.red[400]!,
        Colors.red[500]!,
        Colors.red[600]!,
        Colors.red[700]!,
      ]),
      duration: Duration(seconds: timeout),
      borderRadius: BorderRadius.circular(25),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(8),
    );
  }
}
