import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart';
import 'package:c4d/module_branches/ui/state/init_branches_state/init_branches_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitBranchesStateManager extends StateManagerHandler {
  final BranchesListService _branchesListService;

  Stream<States> get stateStream => stateSubject.stream;

  InitBranchesStateManager(
    this._branchesListService,
  );
  void createBranch(
      InitBranchesScreenState screenState, CreateListBranchesRequest request) {
    stateSubject.add(LoadingState(screenState));
    _branchesListService.addBranches(request).then((value) {
      if (value.hasError) {
        stateSubject.add(InitAccountStateSelectBranch(screenState));
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        screenState.moveToOrder();
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.addBranchSuccess);
      }
    });
  }
}
