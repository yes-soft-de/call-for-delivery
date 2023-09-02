import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart';
import 'package:c4d/module_branches/ui/state/update_branches_state/update_branches_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateBranchStateManager extends StateManagerHandler {
  final BranchesListService _branchesListService;
  UpdateBranchStateManager(this._branchesListService);

  Stream<States> get stateStream => stateSubject.stream;

  void updateBranch(
      UpdateBranchScreenState state, UpdateBranchesRequest request) {
    stateSubject.add(LoadingState(state));
    _branchesListService.updateBranch(request).then((value) {
      if (value.hasError) {
        state.moveNext(false);
      } else {
        stateSubject.add(UpdateBranchStateLoaded(state));
        state.moveNext(true);
      }
    });
  }

  void createBranch(
      UpdateBranchScreenState state, CreateListBranchesRequest request) {
    stateSubject.add(LoadingState(state));
    _branchesListService.createBranch(request).then((value) {
      if (value.hasError) {
        state.moveNextAfterCreate(false);
      } else {
        stateSubject.add(UpdateBranchStateLoaded(state));
        state.moveNextAfterCreate(true);
      }
    });
  }
}
