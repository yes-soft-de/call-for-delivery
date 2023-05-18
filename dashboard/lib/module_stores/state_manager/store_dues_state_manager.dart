import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_stores/model/stores_dues/store_dues_model.dart';
import 'package:c4d/module_stores/request/store_dues_request.dart';
import 'package:c4d/module_stores/request/store_payment_request.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/stores_dues/store_dues_screen.dart';
import 'package:c4d/module_stores/ui/state/stores_dues/store_due_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StoreDuesStateManager {
  final StoresService _storesService;
  final PaymentsService _paymentsService;
  final PublishSubject<States> _stateSubject = new PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreDuesStateManager(this._storesService, this._paymentsService);

  void makePayments(
      StoreDuesScreenState screenState, CreateStorePaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _paymentsService.paymentToStore(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            ;
        getStoreDues(screenState, screenState.filter);
      } else {
        getStoreDues(screenState, screenState.filter);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.paymentSuccessfully)
            ;
      }
    });
  }

  void getStoreDues(StoreDuesScreenState screenState, StoreDuesRequest request,
      [bool loading = true]) {
    if (loading) {
      _stateSubject.add(LoadingState(screenState));
    }
    _storesService.getStoreDues(request).then((value) {
      if (value.hasError) {
        _stateSubject
            .add(StoreDuesLoadedState(screenState, [], error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(StoreDuesLoadedState(screenState, [], empty: true));
      } else {
        StoreDuesModel model = value as StoreDuesModel;
        _stateSubject.add(StoreDuesLoadedState(screenState, model.data));
      }
    });
  }
}
