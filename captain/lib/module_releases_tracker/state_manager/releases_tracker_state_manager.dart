import 'dart:async';
import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_releases_tracker/service/releases_racker.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReleasesTrackerStateManager extends StateManagerHandler {
  final ReleasesTrackerService _service;

  Stream<States> get stateStream => stateSubject.stream;

  ReleasesTrackerStateManager(this._service);
}
