import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/module_init/response/create_profile_response/create_profile_response.dart';
import 'package:c4d/module_orders/response/terms/terms_respons.dart';
import 'package:c4d/module_profile/repository/profile/profile.repository.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/profile_response.dart';

@injectable
class ProfileManager {
  final ProfileRepository _repository;

  ProfileManager(
    this._repository,
  );

  Future<CreateCaptainProfileResponse?> createCaptainProfile(
          ProfileRequest profileRequest) =>
      _repository.createCaptainProfile(profileRequest);

  Future<ProfileResponse?> getCaptainProfile() =>
      _repository.getCaptainProfile();
  Future<ActionResponse?> changeProfileStatus(bool isOnline) =>
      _repository.changeCaptainStatus(isOnline);

  Future<List<Terms>?> getTerms() => _repository.getTerms();
}
