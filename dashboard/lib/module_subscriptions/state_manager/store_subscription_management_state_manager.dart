import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscriptions_managment_screen.dart';
import 'package:c4d/module_subscriptions/ui/state/subscriptions_management/subscriptions_management_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreSubscriptionManagementStateManager extends StateManagerHandler {
  final SubscriptionsService _subscriptionService;

  Stream<States> get stateStream => stateSubject.stream;

  StoreSubscriptionManagementStateManager(
    this._subscriptionService,
  );

  void renewPackage(
      SubscriptionManagementScreenState screenState, int storeID) {
    stateSubject.add(LoadingState(screenState));
    _subscriptionService.renewPackage(storeID).then((value) {
      if (value.hasError) {
        stateSubject.add(SubscriptionManagementStateLoaded(screenState));

        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        stateSubject.add(SubscriptionManagementStateLoaded(screenState));

        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.successRenew);
      }
    });
  }

  void extendPackage(
      SubscriptionManagementScreenState screenState, int storeID) {
    stateSubject.add(LoadingState(screenState));
    _subscriptionService.extendPackage(storeID).then((value) {
      if (value.hasError) {
        stateSubject.add(SubscriptionManagementStateLoaded(screenState));
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        stateSubject.add(SubscriptionManagementStateLoaded(screenState));
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.packageExtendedSuccessfully);
      }
    });
  }

  void deleteFutureSubscriptions(
      SubscriptionManagementScreenState screenState, int storeID) {
    stateSubject.add(LoadingState(screenState));
    _subscriptionService.deleteFutureSubscriptions(storeID).then((value) {
      if (value.hasError) {
        stateSubject.add(SubscriptionManagementStateLoaded(screenState));
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        stateSubject.add(SubscriptionManagementStateLoaded(screenState));
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.futureSubscriptionsDeletedSuccessfully);
      }
    });
  }
}
