import 'dart:async';
import 'dart:io';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_releases_tracker/service/releases_racker.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../abstracts/state_manager/state_manager_handler.dart';
import '../model/version_info_model.dart';
import '../request/profile_release_request.dart';

@injectable
class ReleasesTrackerStateManager extends StateManagerHandler {
  final ReleasesTrackerService _service;

  Stream<States> get stateStream => stateSubject.stream;

  ReleasesTrackerStateManager(this._service);

  void checkVersion() async {
    var packageInfo = await PackageInfo.fromPlatform();

    var request = ProfileReleaseRequest(
      version: packageInfo.version,
      platformOS: _getPlatform,
    );

    _service.checkForUpdates(request).then(
      (value) {
        if (value.hasError || value.isEmpty) {
          return;
        }
        value as VersionInfoModel;
      },
    );
  }
}

PlatformOS get _getPlatform {
  if (Platform.isAndroid) return PlatformOS.android;
  return PlatformOS.ios;
}
