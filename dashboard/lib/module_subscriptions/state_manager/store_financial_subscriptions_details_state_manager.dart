import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_stores/hive/store_hive_helper.dart';
import 'package:c4d/module_subscriptions/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscriptions/request/delete_captain_offer_request.dart';
import 'package:c4d/module_subscriptions/request/delete_subscription_request.dart';
import 'package:c4d/module_subscriptions/request/update_remaining_cars_request.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_details_screen.dart';
import 'package:c4d/module_subscriptions/ui/state/store_financial_subscriptions_details/store_financial_details_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';
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
  final SubscriptionsService _storesService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreFinancialSubscriptionsDuesDetailsStateManager(
      this._paymentsService, this._storesService);

  void getStorePaymentsDetails(
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
        List<StoreSubscriptionsFinanceModel> models =
            value.data.oldSubscriptions;
        models.addAll(value.data.currentAndFutureSubscriptions);
        screenState.model =
            models.firstWhere((element) => element.id == screenState.model.id);
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
        getStorePaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getStorePaymentsDetails(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void deleteSubscriptions(
      StoreSubscriptionsFinanceDetailsScreenState screenState,
      DeleteSubscriptionsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.deleteSubscription(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getStorePaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getStorePaymentsDetails(screenState);
        Navigator.of(screenState.context).pop();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.subscriptionDeletedSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void deleteCaptainOfferSubscription(
      StoreSubscriptionsFinanceDetailsScreenState screenState,
      DeleteCaptainOfferSubscriptionsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.deleteCaptainOffer(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getStorePaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getStorePaymentsDetails(screenState);
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
        getStorePaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getStorePaymentsDetails(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.deleteSuccess)
            .show(screenState.context);
      }
    });
  }

  void updateRemainingCars(
      StoreSubscriptionsFinanceDetailsScreenState screenState,
      UpdateRemainingCarsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _storesService.updateRemainingCars(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getStorePaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getStorePaymentsDetails(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.updateSuccess)
            .show(screenState.context);
      }
    });
  }
}
