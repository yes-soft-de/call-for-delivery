import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_init/model/profile_post_state.dart';
import 'package:c4d/module_init/response/create_profile_response/create_profile_response.dart';
import 'package:c4d/module_orders/response/terms/terms_respons.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_profile/manager/profile/profile.manager.dart';
import 'package:c4d/module_profile/model/profile_model/profile_model.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/profile_response.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';

@injectable
class ProfileService {
  final ProfileManager _manager;
  final OrdersService _ordersService;

  ProfileService(this._manager, this._ordersService);

  Future<ProfileModel> getProfile() async {
    ProfileResponse? response = await _manager.getCaptainProfile();
    if (response == null) {
      return ProfileModel.error(S.current.networkError);
    }
    String code = response.statusCode.toString();
    if (response.statusCode != '200') {
      return ProfileModel.error(StatusCodeHelper.getStatusCodeMessages(code));
    }
    if (response.data == null) return ProfileModel.empty();
    return ProfileModel.withData(response.data!);
  }

  Future<ProfilePostState> createProfile(ProfileRequest profileRequest) async {
    CreateCaptainProfileResponse? clientOrderResponse =
        await _manager.createCaptainProfile(profileRequest);
    if (clientOrderResponse == null) {
      return ProfilePostState.error(S.current.networkError);
    }
    if (clientOrderResponse.statusCode != '204') {
      return ProfilePostState.error(StatusCodeHelper.getStatusCodeMessages(
          clientOrderResponse.statusCode));
    }
    await _ordersService.insertWatcher();
    return ProfilePostState.empty();
  }

  Future<List<Terms>?> getTerms() async {
    return await _manager.getTerms();
  }
}
