import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_branches/request/create_list_branches/create_list_branches.dart';
import 'package:c4d/module_branches/service/branches_list_service.dart';
import 'package:c4d/module_branches/ui/screens/init_branches/init_branches_screen.dart';
import 'package:c4d/module_branches/ui/state/init_branches_state/init_branches_loaded_state.dart';
import 'package:c4d/module_profile/request/profile/profile_request.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class InitBranchesStateManager {
  final BranchesListService _branchesListService;
  final ProfileService _profileService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  InitBranchesStateManager(this._branchesListService, this._profileService);
  void createBranch(
      InitBranchesScreenState screenState, CreateListBranchesRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _branchesListService.addBranches(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(InitAccountStateSelectBranch(screenState));
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        screenState.moveToOrder();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.addBranchSuccess)
            .show(screenState.context);
      }
    });
  }

  void createProfile(
      ProfileRequest request, InitBranchesScreenState screenState) {
    _profileService.createStoreProfile(request).then(
      (value) {
        if (value.hasError) {
          _stateSubject.add(InitAccountStateSelectBranch(screenState));
          CustomFlushBarHelper.createError(
                  title: S.current.warnning, message: value.error ?? '')
              .show(screenState.context);
        } else {
          screenState.moveToOrder();
          CustomFlushBarHelper.createSuccess(
                  title: S.current.warnning,
                  message: S.current.uploadProfileSuccess)
              .show(screenState.context);
        }
      },
    );
  }
}
