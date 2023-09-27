import 'package:injectable/injectable.dart';

import '../repository/releases_tracker_repository.dart';
import '../request/profile_release_request.dart';
import '../response/profile_release_response/profile_release_response.dart';

@injectable
class ReleasesTrackerManager {
  final ReleasesTrackerRepository _repository;

  ReleasesTrackerManager(
    this._repository,
  );

  Future<ProfileReleaseResponse?> checkForUpdates(
          ProfileReleaseRequest request) =>
      _repository.checkForUpdates(request);
}
