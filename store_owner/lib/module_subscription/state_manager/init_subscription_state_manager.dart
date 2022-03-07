import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_subscription/model/packages.model.dart';
import 'package:c4d/module_subscription/model/packages_categories_model.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:c4d/module_subscription/ui/screens/init_subscription_screen/init_subscription_screen.dart';
import 'package:c4d/module_subscription/ui/state/init_subscriptions_loaded_state.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class InitSubscriptionStateManager {
  final SubscriptionService _initAccountService;
  final ProfileService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  InitSubscriptionStateManager(
    this._initAccountService,
    this._profileService,
    this._authService,
    this._uploadService,
  );
  void getPackages(InitSubscriptionScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _initAccountService.getCategoriesPackages().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getPackages(screenState);
        }, title: S.current.storeAccountInit, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getPackages(screenState);
        },
            title: S.current.storeAccountInit,
            emptyMessage: S.current.homeDataEmpty));
      } else {
        value as PackageCategoriesModel;
        _stateSubject
            .add(InitSubscriptionsLoadedState(screenState, value.data));
      }
    });
  }

  void subscribePackage(
      InitSubscriptionScreenState screenState, int packageId) {
    _stateSubject.add(LoadingState(screenState));
    _initAccountService.subscribePackage(packageId).then((value) {
      if (value.hasError) {
        getPackages(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        screenState.moveNext();
      }
    });
  }
}
