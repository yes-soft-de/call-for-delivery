import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:c4d/module_subscription/ui/screens/store_subscriptions_screen.dart';
import 'package:c4d/module_subscription/ui/state/captain_financial_dues_state/store_subscriptions_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StoreSubscriptionsFinanceStateManager {
  final stateSubject = PublishSubject<States>();
  final SubscriptionService _subscriptionsService;

  StoreSubscriptionsFinanceStateManager(this._subscriptionsService);
  Stream<States> get stateStream => stateSubject.stream;
  void getAccountBalance(StoreSubscriptionsFinanceScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _subscriptionsService.getSubscriptionsFinance().then((value) {
      if (value.hasError) {
        stateSubject.add(
          ErrorState(screenState, onPressed: () {
            getAccountBalance(screenState);
          }, title: S.current.myBalance, error: value.error, hasAppbar: false),
        );
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            hasAppbar: false,
            title: S.current.myBalance, onPressed: () {
          getAccountBalance(screenState);
        }));
      } else {
        value as StoreSubscriptionsFinanceModel;
        stateSubject
            .add(StoreSubscriptionsFinanceStateLoaded(screenState, value.data));
      }
    });
  }
}
