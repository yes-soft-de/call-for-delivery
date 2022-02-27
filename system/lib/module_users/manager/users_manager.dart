import 'package:c4d/module_users/request/update_pass_request.dart';
import 'package:c4d/module_users/repository/users_repository.dart';
import 'package:c4d/module_users/response/action_response.dart';
import 'package:c4d/module_users/response/users_response.dart';
import 'package:injectable/injectable.dart';

import '../request/filter_user_request.dart';


@injectable
class UsersManager {

  final UsersRepository _repository;

  UsersManager(this._repository);

  Future<UsersResponse?> getUsers(FilterUserRequest request) => _repository.getUsers(request);
  Future<ActionResponse?> updatePassword(UpdatePassRequest request) => _repository.updatePassword(request);


}