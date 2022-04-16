import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_supplier/model/supplier_need_support.dart';
import 'package:c4d/module_supplier/service/supplier_service.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_needs_support_screen.dart';
import 'package:c4d/module_supplier/ui/state/supplier_supports/supplier_support_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SupplierNeedsSupportStateManager {
  final SupplierService _service;

  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  SupplierNeedsSupportStateManager(this._service);

  void getSupplierSupport(SupplierNeedsSupportScreenState screenState) {
    _service.getSupplierSupport().then((value) {
      if (value.hasError) {
        _stateSubject.add(SupplierNeedSupportLoadedState(screenState, null,
            error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(SupplierNeedSupportLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        SupplierNeedSupportModel _model = value as SupplierNeedSupportModel;
        _stateSubject
            .add(SupplierNeedSupportLoadedState(screenState, _model.data));
      }
    });
  }
}
