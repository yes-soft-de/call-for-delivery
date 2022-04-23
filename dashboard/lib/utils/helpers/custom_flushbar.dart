import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      backgroundColor: background ?? Colors.green,
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
      backgroundColor: Colors.red,
      duration: Duration(seconds: timeout),
      borderRadius: BorderRadius.circular(25),
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: EdgeInsets.all(8),
    );
  }

  static showSnackSuccess(State screenState, String message, bool loading) {
    if (loading) {
      createSuccess(
              title: S.current.warnning,
              message: S.current.storeUpdatedSuccessfully)
          .show(screenState.context);
    } else {
      Fluttertoast.showToast(msg: message);
    }
  }

  static showSnackFailed(State screenState, String message, bool loading) {
    if (loading) {
      createError(
              title: S.current.warnning, message: message)
          .show(screenState.context);
    } else {
      Fluttertoast.showToast(msg: message);
    }
  }
}
