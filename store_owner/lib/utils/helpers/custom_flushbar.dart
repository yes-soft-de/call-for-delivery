import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/fixed_container.dart';

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
      icon: Icon(
        Icons.info,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundGradient: LinearGradient(colors: [
        background ?? Colors.green.withOpacity(0.7),
        background ?? Colors.green.withOpacity(0.8),
        background ?? Colors.green.withOpacity(0.9),
        background ?? Colors.green,
      ]),
      duration: Duration(seconds: timeout),
      borderRadius: BorderRadius.circular(25),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: margin ?? EdgeInsets.all(8),
      padding: padding ?? EdgeInsets.all(16),
      flushbarPosition: top ? FlushbarPosition.TOP : FlushbarPosition.BOTTOM,
    );
  }

  static Flushbar createError(
      {required String title, required String message, int timeout = 4}) {
    return Flushbar(
      maxWidth: 600,
      title: title,
      message: message,
      icon: Icon(
        Icons.info,
        size: 28.0,
        color: Colors.white,
      ),
      backgroundGradient: LinearGradient(colors: [
        Colors.red.withOpacity(0.7),
        Colors.red.withOpacity(0.8),
        Colors.red.withOpacity(0.9),
        Colors.red,
      ]),
      duration: Duration(seconds: timeout),
      borderRadius: BorderRadius.circular(25),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
    );
  }
}
