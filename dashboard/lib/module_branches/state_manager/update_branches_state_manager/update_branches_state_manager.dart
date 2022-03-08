import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/request/update_branch/update_branch_request.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_branches/ui/screens/update_branches_screen/update_branches_screen.dart';
import 'package:c4d/module_branches/ui/state/update_branches_state/update_branches_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class UpdateBranchStateManager {
  final BranchesListService _branchesListService;
  UpdateBranchStateManager(this._branchesListService);
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  void updateBranch(
      UpdateBranchScreenState state, UpdateBranchesRequest request) {
    _stateSubject.add(LoadingState(state));
    _branchesListService.updateBranch(request).then((value) {
      if (value.hasError) {
        state.moveNext(false);
      } else {
        _stateSubject.add(UpdateBranchStateLoaded(state));
        state.moveNext(true);
      }
    });
  }

  void createBranch(
      UpdateBranchScreenState state, CreateListBranchesRequest request) {
    _stateSubject.add(LoadingState(state));
    _branchesListService.createBranch(request).then((value) {
      if (value.hasError) {
        state.moveNextAfterCreate(false);
      } else {
        _stateSubject.add(UpdateBranchStateLoaded(state));
        state.moveNextAfterCreate(true);
      }
    });
  }
}
