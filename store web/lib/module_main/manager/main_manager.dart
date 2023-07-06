import 'package:injectable/injectable.dart';
import 'package:store_web/module_main/repository/main_repository.dart';
import 'package:store_web/module_main/response/login_response/login_response.dart';
import 'package:store_web/module_main/response/profile_response/profile_response.dart';
import 'package:store_web/module_main/response/store_profile_response.dart';
import 'package:store_web/utils/response/action_response.dart';

@injectable
class MainManager {
  final MainRepository _repository;

  MainManager(this._repository);
  Future<LoginResponse?> getAdminToken() => _repository.getAdminToken();

  Future<ActionResponse?> deleteStore(int storeID, String adminToken) =>
      _repository.deleteStore(storeID, adminToken);

  Future<ProfileResponse?> getOwnerProfile() => _repository.getOwnerProfile();

  Future<StoreProfileResponse?> getStoreProfile(int id, String adminToken) =>
      _repository.getStoreProfile(id, adminToken);
}
