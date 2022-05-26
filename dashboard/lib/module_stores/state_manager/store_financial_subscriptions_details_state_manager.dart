import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/hive/captain_hive_helper.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_stores/hive/store_hive_helper.dart';
import 'package:c4d/module_stores/model/store_subscriptions_financial.dart';
import 'package:c4d/module_stores/service/store_service.dart';
import 'package:c4d/module_stores/ui/screen/store_subscriptions_details_screen.dart';
import 'package:c4d/module_stores/ui/state/store_financial_subscriptions_details/store_financial_details_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class StoreFinancialSubscriptionsDuesDetailsStateManager {
  final PaymentsService _paymentsService;
  final StoresService _storesService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreFinancialSubscriptionsDuesDetailsStateManager(
      this._paymentsService, this._storesService);

  void getCaptainPaymentsDetails(
      StoreSubscriptionsFinanceDetailsScreenState screenState) {
    _storesService
        .getSubscriptionsFinance(StoresHiveHelper().getCurrentStoreID())
        .then((value) {
      if (value.hasError) {
        _stateSubject
            .add(StoreSubscriptionsFinanceDetailsStateLoaded(screenState));
      } else if (value.isEmpty) {
        _stateSubject
            .add(StoreSubscriptionsFinanceDetailsStateLoaded(screenState));
      } else {
        value as StoreSubscriptionsFinanceModel;
        screenState.model = value.data
            .firstWhere((element) => element.id == screenState.model.id);
        _stateSubject
            .add(StoreSubscriptionsFinanceDetailsStateLoaded(screenState));
        screenState.refresh();
      }
    });
  }

  void makePayments(StoreSubscriptionsFinanceDetailsScreenState screenState,
      CreateStorePaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _paymentsService.paymentFromStore(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getCaptainPaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getCaptainPaymentsDetails(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void deletePayment(
      StoreSubscriptionsFinanceDetailsScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _paymentsService.deletePaymentToStore(id).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getCaptainPaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getCaptainPaymentsDetails(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.deleteSuccess)
            .show(screenState.context);
      }
    });
  }
}
