import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_categories/service/store_categories_service.dart';
import 'package:c4d/module_subscriptions/request/store_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/init_subscription_screen.dart';
import 'package:c4d/module_subscriptions/ui/state/subscribe_to_packages/init_subscriptions_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class InitSubscriptionStateManager extends StateManagerHandler {
  final SubscriptionsService _initAccountService;

  Stream<States> get stateStream => stateSubject.stream;

  InitSubscriptionStateManager(
    this._initAccountService,
  );
  void getCategories(CreateSubscriptionScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    getIt<CategoriesService>().getCategories().then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getCategories(screenState);
        }, title: S.current.storeAccountInit, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getCategories(screenState);
        },
            title: S.current.storeAccountInit,
            emptyMessage: S.current.homeDataEmpty));
      } else {
        value as PackagesCategoryModel;
        stateSubject
            .add(InitSubscriptionsLoadedState(screenState, value.data, []));
      }
    });
  }

  void getPackages(CreateSubscriptionScreenState screenState, int id) {
    getIt<CategoriesService>().getPackagesByCategory(id).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getPackages(screenState, id);
        }, title: S.current.storeAccountInit, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState, onPressed: () {
          getPackages(screenState, id);
        },
            title: S.current.storeAccountInit,
            emptyMessage: S.current.homeDataEmpty));
      } else {
        value as PackagesModel;
        stateSubject.add(InitSubscriptionsLoadedState(
            screenState, screenState.categories, value.data));
      }
    });
  }

  void subscribePackage(CreateSubscriptionScreenState screenState,
      StoreSubscribeToPackageRequest request) {
    stateSubject.add(LoadingState(screenState));
    _initAccountService.subscribePackage(request).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        screenState.moveNext();
      }
    });
  }
}
