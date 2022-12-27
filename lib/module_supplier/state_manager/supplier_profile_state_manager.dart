import 'package:c4d/module_supplier/model/porfile_model.dart';
import 'package:c4d/module_supplier/request/enable_supplier.dart';
import 'package:c4d/module_supplier/service/supplier_service.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_profile_screen.dart';
import 'package:c4d/module_supplier/ui/state/supplier_profile/supplier_profile.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';

import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class SupplierProfileStateManager {
  final SupplierService _service;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  SupplierProfileStateManager(this._service);

  void getSupplierProfile(
      SupplierProfileScreenState screenState, int captainId) {
    _stateSubject.add(LoadingState(screenState));
    _service.getSupplierProfile(captainId).then((value) {
      if (value.hasError) {
        _stateSubject.add(
            SupplierProfileLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(SupplierProfileLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        ProfileSupplierModel _model = value as ProfileSupplierModel;
        _stateSubject.add(SupplierProfileLoadedState(screenState, _model.data));
      }
    });
  }

  void enableSupplier(SupplierProfileScreenState screenState, int captainId,
      EnableSupplierRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _service.enableSupplier(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getSupplierProfile(screenState, captainId);
      } else {
        getSupplierProfile(screenState, captainId);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.supplierUpdatedSuccessfully)
            .show(screenState.context);
        getIt<GlobalStateManager>().updateList();
      }
    });
  }
}
