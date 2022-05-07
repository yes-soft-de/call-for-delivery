import 'package:c4d/module_supplier/model/inActiveModel.dart';
import 'package:c4d/module_supplier/service/supplier_service.dart';
import 'package:c4d/module_supplier/ui/screen/in_active_supplier_screen.dart';
import 'package:c4d/module_supplier/ui/state/in_active/in_active_captains_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';

@injectable
class InActiveSupplierStateManager {
  final SupplierService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();
  Stream<States> get stateStream => _stateSubject.stream;

  InActiveSupplierScreenState? _captainsScreenState;
  InActiveSupplierScreenState? get state => _captainsScreenState;

  InActiveSupplierStateManager(this._captainsService);

  void getInActiveSupplier(InActiveSupplierScreenState screenState) {
    _captainsScreenState = screenState;
    _stateSubject.add(LoadingState(screenState));
    _captainsService.getInActiveSupplier().then((value) {
      if (value.hasError) {
        _stateSubject.add(
            InActiveSupplierLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(InActiveSupplierLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        InActiveModel _model = value as InActiveModel;
        _stateSubject
            .add(InActiveSupplierLoadedState(screenState, _model.data));
      }
    });
  }
}
