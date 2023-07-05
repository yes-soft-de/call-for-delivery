import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/request/payment/paymnet_status_request.dart';
import 'package:c4d/module_orders/service/orders/orders.service.dart';
import 'package:c4d/module_subscription/model/new_subscription_balance_model.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:c4d/module_subscription/ui/screens/new_subscription_balance_screen/new_subscription_balance_screen.dart';
import 'package:c4d/module_subscription/ui/state/new_subscription_balance/new_subscriptions_balance_loaded_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class NewSubscriptionBalanceStateManager {
  final SubscriptionService _subscriptionService;
  final OrdersService _ordersService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  final PublishSubject<AsyncSnapshot<Object?>> _captainOffersSubject =
      PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;
  Stream<AsyncSnapshot<Object?>> get captainOffersStream =>
      _captainOffersSubject.stream;

  NewSubscriptionBalanceStateManager(
      this._subscriptionService, this._ordersService);

  void getNewBalance(NewSubscriptionBalanceScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _subscriptionService.getNewSubscriptionBalance().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(
          screenState,
          onPressed: () {
            getNewBalance(screenState);
          },
          title: S.current.mySubscription,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(
          screenState,
          onPressed: () {
            getNewBalance(screenState);
          },
          title: S.current.mySubscription,
          emptyMessage: S.current.homeDataEmpty,
        ));
      } else {
        value as NewSubscriptionBalanceModel;
        _stateSubject
            .add(NewSubscriptionBalanceLoadedState(screenState, value.data));
      }
    });
  }

  void makePayment(NewSubscriptionBalanceScreenState screenState,
      PaymentStatusRequest request) {
    _ordersService.makePayment(request).then((value) {
      if (value.isEmpty) {
        CustomFlushBarHelper.createSuccess(
          title: S.current.warnning,
          message: S.current.paymentSuccess,
        ).show(screenState.context);
      } else {
        CustomFlushBarHelper.createError(
          title: S.current.warnning,
          message: value.error ?? S.current.errorHappened,
        ).show(screenState.context);
        getIt<GlobalStateManager>().update();
        screenState.getBalance();
      }
    });
  }
}
