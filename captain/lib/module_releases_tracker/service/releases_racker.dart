import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_releases_tracker/manager/releases_tracker_manager.dart';
import 'package:c4d/module_releases_tracker/request/profile_release_request.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReleasesTrackerService {
  final ReleasesTrackerManager _manager;

  ReleasesTrackerService(this._manager);

  Future<DataModel> checkForUpdates(ProfileReleaseRequest request) async {
    ActionResponse? response = await _manager.checkForUpdates(request);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) return DataModel.empty();
    return DataModel.empty();
  }
}
