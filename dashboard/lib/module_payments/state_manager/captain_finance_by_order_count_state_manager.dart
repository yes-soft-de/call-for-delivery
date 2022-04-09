import 'package:c4d/module_payments/model/store_balance_model.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_count_screen.dart';
import 'package:c4d/module_payments/ui/state/captain_finance/captain_finance_by_order_count.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';

@injectable
class CaptainFinanceByOrderCountStateManager {
  final PaymentsService _storePaymentsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CaptainFinanceByOrderCountStateManager(this._storePaymentsService);


  void getFinances(CaptainFinanceByCountOrderScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _storePaymentsService.getCaptainFinanceByOrderCounts().then((value) {
      if (value.hasError) {
        _stateSubject.add(CaptainFinanceByOrderCountLoadedState(
          screenState,
          null,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        _stateSubject.add(
            CaptainFinanceByOrderCountLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        StoreBalanceModel _balance = value as StoreBalanceModel;
        _stateSubject.add(CaptainFinanceByOrderCountLoadedState(screenState, _balance.data));
      }
    });
  }

  void createFinance(
      CaptainFinanceByCountOrderScreenState screenState, CreateStorePaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _storePaymentsService.paymentToStore(request).then((value) {
      if (value.hasError) {
        getFinances(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        getFinances(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }

}
