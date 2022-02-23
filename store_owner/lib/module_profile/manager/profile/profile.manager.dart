import 'package:c4d/module_profile/repository/profile/profile.repository.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/response/create_branch_response.dart';
import 'package:c4d/module_profile/response/get_records_response.dart';
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

  Future<ProfileResponse?> getOwnerProfile() => _repository.getOwnerProfile();

  Future<Branch?> createBranch(CreateBranchRequest request) =>
      _repository.createBranch(request);

  Future<List<Branch>?> getMyBranches() => _repository.getMyBranches();

  Future<List<ActivityRecord>?> getMyLog() => _repository.getUserActivityLog();

//  Future <List<Terms>> getTerms(UserRole role) => _repository.getTerms(role);

}
