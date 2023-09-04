import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/utils/logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class StateManagerHandler {
  @protected
  final PublishSubject<States> stateSubject = PublishSubject();

  @mustCallSuper
  void dispose() {
    stateSubject.close();
    Logger.info(
        'StateManagement', '\n\n$runtimeType disposed successfully\n\n');
  }
}
