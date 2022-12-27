import 'package:c4d/abstracts/response/action_response.dart';
import 'package:c4d/module_branches/repository/branches_repository.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/response/branches/branches_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class BranchesManager {
  final BranchesRepository _repository;

  BranchesManager(this._repository);

  Future<BranchListResponse?> getBranches(String id) async =>
      await _repository.getBranches(id);
  Future<ActionResponse?> updateBranch(UpdateBranchesRequest request) async =>
      await _repository.updateBranch(request);
  Future<ActionResponse?> addBranch(CreateListBranchesRequest request) async =>
      await _repository.addBranch(request);

  Future<ActionResponse?> createBrannch(
          CreateListBranchesRequest request) async =>
      await _repository.createBranch(request);

  Future<ActionResponse?> deleteBranch(int id) async =>
      await _repository.deleteBranch(id);
}
