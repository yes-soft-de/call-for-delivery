import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_expired_screen.dart';
import 'package:c4d/module_subscriptions/ui/state/store_expired_finaincial_subscription_state/store_subscriptions_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreSubscriptionsExpiredFinanceStateManager extends StateManagerHandler {
  final SubscriptionsService _serviceService;

  StoreSubscriptionsExpiredFinanceStateManager(this._serviceService);
  Stream<States> get stateStream => stateSubject.stream;
  void getAccountBalance(
      StoreSubscriptionsExpiredFinanceScreenState screenState, int storeID) {
    stateSubject.add(LoadingState(screenState));
    _serviceService.getSubscriptionsFinance(storeID).then((value) {
      if (value.hasError) {
        stateSubject.add(
          ErrorState(screenState, onPressed: () {
            getAccountBalance(screenState, storeID);
          }, title: S.current.myBalance, error: value.error, hasAppbar: false),
        );
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            hasAppbar: false,
            title: S.current.myBalance, onPressed: () {
          getAccountBalance(screenState, storeID);
        }));
      } else {
        value as StoreSubscriptionsFinanceModel;
        stateSubject.add(StoreSubscriptionsExpiredFinanceStateLoaded(
            screenState, value.data.oldSubscriptions));
      }
    });
  }
}
