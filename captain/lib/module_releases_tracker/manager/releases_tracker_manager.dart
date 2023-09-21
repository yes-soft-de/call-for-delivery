import 'package:c4d/module_releases_tracker/repository/releases_tracker_repository.dart';
import 'package:c4d/module_releases_tracker/request/profile_release_request.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReleasesTrackerManager {
  final ReleasesTrackerRepository _repository;

  ReleasesTrackerManager(
    this._repository,
  );

  Future<ActionResponse?> checkForUpdates(ProfileReleaseRequest request) =>
      _repository.checkForUpdates(request);
}
