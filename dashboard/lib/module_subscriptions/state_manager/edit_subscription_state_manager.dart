import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_categories/model/package_categories_model.dart';
import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_categories/service/store_categories_service.dart';
import 'package:c4d/module_subscriptions/request/store_edit_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/edit_subscription_screen.dart';
import 'package:c4d/module_subscriptions/ui/state/subscribe_to_packages/edit_subscriptions_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class EditSubscriptionStateManager {
  final SubscriptionsService _initAccountService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  EditSubscriptionStateManager(
    this._initAccountService,
  );
  void getCategories(EditSubscriptionScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    getIt<CategoriesService>().getCategories().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getCategories(screenState);
        }, title: S.current.storeAccountInit, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getCategories(screenState);
        },
            title: S.current.storeAccountInit,
            emptyMessage: S.current.homeDataEmpty));
      } else {
        value as PackagesCategoryModel;
        _stateSubject
            .add(EditSubscriptionsLoadedState(screenState, value.data, []));
      }
    });
  }

  void getPackages(EditSubscriptionScreenState screenState, int id) {
    getIt<CategoriesService>().getPackagesByCategory(id).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getPackages(screenState, id);
        }, title: S.current.storeAccountInit, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getPackages(screenState, id);
        },
            title: S.current.storeAccountInit,
            emptyMessage: S.current.homeDataEmpty));
      } else {
        value as PackagesModel;
        _stateSubject.add(EditSubscriptionsLoadedState(
            screenState, screenState.categories, value.data));
      }
    });
  }

  void subscribePackage(EditSubscriptionScreenState screenState,
      EditStoreSubscribeToPackageRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _initAccountService.editSubscribePackage(request).then((value) {
      if (value.hasError) {
        getCategories(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            ;
      } else {
        screenState.moveNext();
      }
    });
  }
}
