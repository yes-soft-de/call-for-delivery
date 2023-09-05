import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branches/branches_model.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_branches/ui/screens/branches_list_screen/branches_list_screen.dart';
import 'package:c4d/module_branches/ui/state/branches_list_state/branches_list_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class BranchesListStateManager extends StateManagerHandler {
  final BranchesListService _branchesListService;

  Stream<States> get stateStream => stateSubject.stream;

  BranchesListStateManager(
    this._branchesListService,
  );
  void getBranchesList(BranchesListScreenState screenState, String id) {
    stateSubject.add(LoadingState(screenState));
    _branchesListService.getBranches(id).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getBranchesList(screenState, id);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getBranchesList(screenState, id);
        },
            title: '',
            emptyMessage: S.current.thereIsNoBranches,
            hasAppbar: false));
      } else {
        var data = value as BranchesModel;
        stateSubject.add(BranchListStateLoaded(data.data, screenState));
      }
    });
  }

  void deleteBranch(
      BranchesListScreenState screenState, int id, String storeID) {
    stateSubject.add(LoadingState(screenState));
    _branchesListService.deleteBranch(id).then((value) {
      if (value.hasError) {
        getBranchesList(screenState, storeID);
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        getBranchesList(screenState, storeID);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.deleteBranchSuccess);
      }
    });
  }
}
