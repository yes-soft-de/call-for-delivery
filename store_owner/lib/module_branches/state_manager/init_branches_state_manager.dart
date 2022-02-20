import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/model/branch/branch_model.dart';
import 'package:c4d/module_branches/request/create_branch_request/create_branch_request.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart';
import 'package:c4d/module_branches/ui/state/init_branches_state/init_branches_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class InitBranchesStateManager {
  final BranchesListService _branchesListService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  InitBranchesStateManager(
    this._branchesListService,
  );
  void createBranch(
      InitBranchesScreenState screenState, CreateBrancheRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _branchesListService.addBranch(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        _stateSubject.add(InitAccountStateSelectBranch(screenState));
      }
    });
  }
}
