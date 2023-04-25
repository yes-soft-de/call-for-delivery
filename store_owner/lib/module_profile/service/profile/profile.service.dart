import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/model/store_balance_model.dart';
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/profile_response/profile_response.dart';
import 'package:c4d/module_profile/response/store_payments_response/store_payments_response.dart';
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

    ProfileModel profile = ProfileModel.withData(response);

    _preferencesHelper.setProfileId(profile.data.id ?? -1);

    return profile;
  }

  Future<DataModel> updateProfile(ProfileRequest profileRequest) async {
    ActionResponse? response = await _manager.updateProfile(profileRequest);
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

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

  Future<DataModel> getStorePayments() async {
    StorePaymentsResponse? actionResponse = await _manager.getStoreBalance();
    if (actionResponse == null) {
      return DataModel.withError(S.current.networkError);
    }
    if (actionResponse.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(actionResponse.statusCode));
    }
    return StoreBalanceModel.withData(actionResponse.data ?? []);
  }
}
