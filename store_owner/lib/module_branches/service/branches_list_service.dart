import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/manager/branches_manager.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/response/branches/branches_response.dart';
import 'package:c4d/module_profile/prefs_helper/profile_prefs_helper.dart';
import 'package:c4d/module_profile/request/branch/create_branch_request.dart';
import 'package:c4d/utils/helpers/status_code_helper.dart';
import 'package:c4d/utils/response/action_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class BranchesListService {
  final BranchesManager _manager;
  final ProfilePreferencesHelper _preferencesHelper;
  BranchesListService(this._manager, this._preferencesHelper);

  Future<DataModel> getBranches() async {
    BranchListResponse? response = await _manager.getBranches();
    if (response == null) return DataModel.withError(S.current.networkError);
    if (response.statusCode != '200') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    if (response.data == null) {
      return DataModel.empty();
    }
    return BranchesModel.withData(response);
  }

  Future<DataModel> updateBranch(UpdateBranchesRequest request) async {
    ActionResponse? response = await _manager.updateBranch(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> addBranch(CreateBrancheRequest request) async {
    ActionResponse? response = await _manager.addBranch(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> createBranch(CreateBranchRequest request) async {
    ActionResponse? response = await _manager.createBrannch(request);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '201') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }

  Future<DataModel> deleteBranch(int id) async {
    ActionResponse? response = await _manager.deleteBranch(id);
    if (response == null) {
      return DataModel.withError(S.current.networkError);
    } else if (response.statusCode != '204') {
      return DataModel.withError(
          StatusCodeHelper.getStatusCodeMessages(response.statusCode));
    }
    return DataModel.empty();
  }
}
