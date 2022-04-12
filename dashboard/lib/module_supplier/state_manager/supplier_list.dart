import 'package:c4d/module_supplier/model/inActiveModel.dart';
import 'package:c4d/module_supplier/service/supplier_service.dart';
import 'package:c4d/module_supplier/ui/screen/supplier_list_screen.dart';
import 'package:c4d/module_supplier/ui/state/supplier_list/supplier_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';

@injectable
class SuppliersStateManager {
  final SupplierService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  SuppliersScreenState? _captainsScreenState;
  Stream<States> get stateStream => _stateSubject.stream;
  SuppliersScreenState? get state => _captainsScreenState;

  SuppliersStateManager(this._captainsService);

  void getSuppliers(SuppliersScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getSuppliers().then((value) {
      if (value.hasError) {
        _stateSubject
            .add(SupplierLoadedState(screenState, [], error: value.error));
      } else if (value.isEmpty) {
        _stateSubject
            .add(SupplierLoadedState(screenState, [], empty: value.isEmpty));
      } else {
        InActiveModel _model = value as InActiveModel;
        _stateSubject.add(SupplierLoadedState(screenState, _model.data  ));
      }
    });
  }
}
