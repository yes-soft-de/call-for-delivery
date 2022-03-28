import 'package:c4d/module_profile/repository/profile/profile.repository.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/profile_response/profile_response.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileManager {
  final ProfileRepository _repository;

  ProfileManager(
    this._repository,
  );

  Future<ActionResponse?> createOwnerProfile(ProfileRequest profileRequest) =>
      _repository.createOwnerProfile(profileRequest);
  Future<ActionResponse?> updateProfile(ProfileRequest profileRequest) =>
      _repository.updateProfile(profileRequest);
  Future<ProfileResponse?> getOwnerProfile() => _repository.getOwnerProfile();
}
