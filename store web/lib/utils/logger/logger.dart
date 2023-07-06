import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

@injectable
@singleton
class Logger {
  void info(String tag, String msg) {
    String time = DateTime.now().toString();

    if (_shouldPrintLog()) {
      log(
        '\x1B[34m$time: \t $tag \t $msg\x1B[0m',
        name: tag,
      );
    }
  }

  void warn(String tag, String msg) {
    String time = DateTime.now().toString();

    if (_shouldPrintLog()) {
      log('\x1B[33m$time: \t $tag \t $msg\x1B[0m', name: tag);
    }
  }

  void error(String tag, String msg, StackTrace? trace) {
    String time = DateTime.now().toString();
    if (_shouldPrintLog()) {
      log(
        '\x1B[31m🚨 $time: \t $tag \t $msg\x1b[0m',
        name: tag,
        stackTrace: trace,
      );
    }
    if (!kIsWeb) {

    }
  }

  bool _shouldPrintLog() {
    if (!kDebugMode) return false;
    return true;
  }
}
