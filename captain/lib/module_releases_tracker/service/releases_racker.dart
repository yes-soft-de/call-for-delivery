import 'package:injectable/injectable.dart';

import '../../abstracts/data_model/data_model.dart';
import '../../generated/l10n.dart';
import '../../utils/helpers/status_code_helper.dart';
import '../manager/releases_tracker_manager.dart';
import '../model/version_info_model.dart';
import '../request/profile_release_request.dart';
import '../response/profile_release_response/profile_release_response.dart';

@injectable
class ReleasesTrackerService {
  final ReleasesTrackerManager _manager;

  ReleasesTrackerService(this._manager);

  Future<DataModel> checkForUpdates(ProfileReleaseRequest request) async {
    ProfileReleaseResponse? response = await _manager.checkForUpdates(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    
    return VersionInfoModel.withData(response);
  }
}
