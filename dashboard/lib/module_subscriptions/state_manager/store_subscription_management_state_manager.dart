import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscriptions_managment_screen.dart';
import 'package:c4d/module_subscriptions/ui/state/subscriptions_management/subscriptions_management_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class StoreSubscriptionManagementStateManager {
  final SubscriptionsService _subscriptionService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  StoreSubscriptionManagementStateManager(
    this._subscriptionService,
  );

  void renewPackage(
      SubscriptionManagementScreenState screenState, int storeID) {
    _stateSubject.add(LoadingState(screenState));
    _subscriptionService.renewPackage(storeID).then((value) {
      if (value.hasError) {
        _stateSubject.add(SubscriptionManagementStateLoaded(screenState));

        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        _stateSubject.add(SubscriptionManagementStateLoaded(screenState));

        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.successRenew)
            .show(screenState.context);
      }
    });
  }

  void extendPackage(
      SubscriptionManagementScreenState screenState, int storeID) {
    _stateSubject.add(LoadingState(screenState));
    _subscriptionService.extendPackage(storeID).then((value) {
      if (value.hasError) {
        _stateSubject.add(SubscriptionManagementStateLoaded(screenState));
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        _stateSubject.add(SubscriptionManagementStateLoaded(screenState));
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.packageExtendedSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void deleteFutureSubscriptions(
      SubscriptionManagementScreenState screenState, int storeID) {
    _stateSubject.add(LoadingState(screenState));
    _subscriptionService.deleteFutureSubscriptions(storeID).then((value) {
      if (value.hasError) {
        _stateSubject.add(SubscriptionManagementStateLoaded(screenState));
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        _stateSubject.add(SubscriptionManagementStateLoaded(screenState));
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.futureSubscriptionsDeletedSuccessfully)
            .show(screenState.context);
      }
    });
  }
}
