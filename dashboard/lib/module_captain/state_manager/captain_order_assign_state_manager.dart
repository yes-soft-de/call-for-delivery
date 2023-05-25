import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captains_order_model.dart';
import 'package:c4d/module_captain/request/assign_order_to_captain_request.dart';
import 'package:c4d/module_captain/ui/screen/captains_assign_order_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_order_assign.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/utils/helpers/firestore_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/service/captains_service.dart';

@injectable
class CaptainAssignOrderStateManager {
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  CaptainAssignOrderScreenState? _captainsScreenState;
  Stream<States> get stateStream => _stateSubject.stream;
  CaptainAssignOrderScreenState? get state => _captainsScreenState;

  CaptainAssignOrderStateManager(this._captainsService);

  void getCaptains(CaptainAssignOrderScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getCaptainOrder().then((value) {
      if (value.hasError) {
        _stateSubject.add(CaptainAssignOrderLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(CaptainAssignOrderLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainOrderModel _model = value as CaptainOrderModel;
        _stateSubject
            .add(CaptainAssignOrderLoadedState(screenState, _model.data));
      }
    });
  }

  void assignOrderToCaptain(CaptainAssignOrderScreenState screenState,
      AssignOrderToCaptainRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _captainsService.assignOrderToCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            ;
        getCaptains(screenState);
      } else {
        FireStoreHelper().backgroundThread('Trigger');
        Navigator.of(screenState.context).pop();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.orderAssignedSuccessfully)
            ;
      }
    });
  }
}
