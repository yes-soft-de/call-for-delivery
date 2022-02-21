import 'package:c4d/module_branches/repository/branches_repository.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/response/branches/branches_response.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class BranchesManager {
  final BranchesRepository _repository;

  BranchesManager(this._repository);

  Future<BranchListResponse?> getBranches() async =>
      await _repository.getBranches();
  Future<ActionResponse?> updateBranch(UpdateBranchesRequest request) async =>
      await _repository.updateBranch(request);
  Future<ActionResponse?> addBranch(CreateBrancheRequest request) async =>
      await _repository.addBranch(request);

  Future<ActionResponse?> createBrannch(CreateBranchRequest request) async =>
      await _repository.createBranch(request);
}
