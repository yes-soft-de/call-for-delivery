import 'package:c4d/module_payments/model/store_balance_model.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_payments/ui/state/store_account/store_balance_state.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/ui/screen/store_balance_screen.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';

@injectable
class StoreBalanceStateManager {
  final PaymentsService _storePaymentsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreBalanceStateManager(this._storePaymentsService);

  void getBalance(StoreBalanceScreenState screenState, int storeID) {
    _stateSubject.add(LoadingState(screenState));
    _storePaymentsService.getStorePayments(storeID).then((value) {
      if (value.hasError) {
        _stateSubject.add(StoreBalanceLoadedState(
          screenState,
          null,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        _stateSubject.add(
            StoreBalanceLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        StoreBalanceModel _balance = value as StoreBalanceModel;
        _stateSubject.add(StoreBalanceLoadedState(screenState, _balance.data));
      }
    });
  }

  void payForStore(
      StoreBalanceScreenState screenState, CreateStorePaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _storePaymentsService.paymentToStore(request).then((value) {
      if (value.hasError) {
        getBalance(screenState, request.storeId ?? -1);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            ;
      } else {
        getBalance(screenState, request.storeId ?? -1);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.paymentSuccessfully)
            ;
      }
    });
  }

  void deletePayment(StoreBalanceScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _storePaymentsService.deletePaymentFromStore(id).then((value) {
      if (value.hasError) {
        getBalance(screenState, screenState.storeID);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            ;
      } else {
        getBalance(screenState, screenState.storeID);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.paymentsDeletedSuccessfully)
            ;
      }
    });
  }
}
