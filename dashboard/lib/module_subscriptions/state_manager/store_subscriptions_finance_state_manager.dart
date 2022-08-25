import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/store_subscriptions_screen.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../ui/state/subscriptions_finance/store_subscriptions_state.dart';

@injectable
class StoreSubscriptionsFinanceStateManager {
  final stateSubject = PublishSubject<States>();
  final SubscriptionsService _serviceService;

  StoreSubscriptionsFinanceStateManager(this._serviceService);
  Stream<States> get stateStream => stateSubject.stream;
  void getAccountBalance(
      StoreSubscriptionsFinanceScreenState screenState, int storeID) {
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
        stateSubject
            .add(StoreSubscriptionsFinanceStateLoaded(screenState, value.data));
      }
    });
  }
}
