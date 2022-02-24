import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/model/activity_model/activity_model.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/response/profile_response/profile_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileService {
  final ProfileManager _manager;
  final ProfilePreferencesHelper _preferencesHelper;
  final AuthService _authService;

  ProfileService(
    this._manager,
    this._preferencesHelper,
    this._authService,
  );
  Future<DataModel> getProfile() async {
    ProfileResponse? response = await _manager.getOwnerProfile();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return ProfileModel.withData(response);
  }

  Future<bool> createProfile(ProfileRequest profileRequest) async {
    return false;
  }

  Future<bool> updateProfile(ProfileRequest profileRequest) async {
    //     return _manager.createOwnerProfile(profileRequest);
    return false;
  }

  Future<List<Branch>?> getMyBranches() async {
    List<Branch>? branches = await _preferencesHelper.getSavedBranch();

    if (branches == null) {
      // Get the Branches from the backend
      branches = await _manager.getMyBranches();
      await _preferencesHelper.cacheBranch(branches ?? []);
    }

    return branches;
  }

  Future<List<ActivityModel>> getActivity() async {
    var records = await _manager.getMyLog();
    var activity = <int, ActivityModel>{};
    if (records == null) {
      return [];
    }
    if (records.isEmpty) {
      return [];
    }
    records.forEach((e) {
      if (e.state == 'delivered') {
        activity[e.id ?? 0] = ActivityModel(
            startDate: DateTime.fromMillisecondsSinceEpoch(
                e.record?.first.date?.timestamp ?? 0 * 1000),
            endDate: DateTime.fromMillisecondsSinceEpoch(
                e.record?.last.date?.timestamp ?? 0 * 1000),
            activity: '${e.brancheName}, #${e.id.toString()}');
      }
    });

    return activity.values.toList();
  }

  String getLocalizedState(String status) {
    if (status == 'pending') {
      return S.current.orderIsCreated;
    } else if (status == 'on way to pick order') {
      return S.current.captainAcceptedOrder;
    } else if (status == 'in store' || status == 'in_store') {
      return S.current.captainInStore;
    } else if (status == 'ongoing' || status == 'piked') {
      return S.current.captainStartedDelivery;
    } else if (status == 'cash') {
      return S.current.captainGotCash;
    } else if (status == 'delivered') {
      return S.current.orderIsFinished;
    }
    return status;
  }

  // Future<List<Terms>> getTerms() async {
  //   var role = await _authService.userRole;
  //   return await _manager.getTerms(role);
  // }
  // new service function form
  Future<DataModel> createStoreProfile(ProfileRequest request) async {
    ActionResponse? actionResponse = await _manager.createOwnerProfile(request);
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    } else if (actionResponse.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return DataModel.empty();
  }
}
