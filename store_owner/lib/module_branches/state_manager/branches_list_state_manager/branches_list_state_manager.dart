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
import 'package:rxdart/rxdart.dart';

@injectable
class BranchesListStateManager {
  final BranchesListService _branchesListService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  BranchesListStateManager(
    this._branchesListService,
  );
  void getBranchesList(BranchesListScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _branchesListService.getBranches().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getBranchesList(screenState);
        }, title: '', error: value.error, hasAppbar: false));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getBranchesList(screenState);
        }, title: '', emptyMessage: S.current.thereIsNoBranches, hasAppbar: false));
      } else {
        var data = value as BranchesModel;
        _stateSubject.add(BranchListStateLoaded(data.data, screenState));
      }
    });
  }

  void deleteBranch(BranchesListScreenState screenState, int id) {
    _stateSubject.add(LoadingState(screenState));
    _branchesListService.deleteBranch(id).then((value) {
      if (value.hasError) {
        getBranchesList(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        getBranchesList(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.deleteBranchSuccess)
            .show(screenState.context);
      }
    });
  }
}
