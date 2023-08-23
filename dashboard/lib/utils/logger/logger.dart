import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

@injectable
@singleton
class Logger {
  static void info(String tag, String msg) {
    String time = DateTime.now().toString();

    if (_shouldPrintLog())
      log(
        '\x1B[34m$time: \t $tag \t $msg\x1B[0m',
        name: tag,
      );
  }

  static void warn(String tag, String msg) {
    String time = DateTime.now().toString();

    if (_shouldPrintLog())
      log('\x1B[33m$time: \t $tag \t $msg\x1B[0m', name: tag);
  }

  static void error(String tag, String msg, StackTrace? trace) {
    String time = DateTime.now().toString();
    if (_shouldPrintLog())
      log(
        '\x1B[31m🚨 $time: \t $tag \t $msg\x1b[0m',
        name: tag,
        stackTrace: trace,
      );
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(
        '$time: \t $tag \t $msg',
        trace,
        printDetails: false,
      );
      // FirebaseCrashlytics.instance.log('$time: \t $tag \t $msg');
      FirebaseCrashlytics.instance.sendUnsentReports();
    }
  }

  static bool _shouldPrintLog() {
    if (!kDebugMode) return true;
    return true;
  }
}
