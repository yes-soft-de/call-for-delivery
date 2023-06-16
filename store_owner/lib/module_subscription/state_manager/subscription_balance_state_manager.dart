import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_subscription/model/captain_offers_model.dart';
import 'package:c4d/module_subscription/model/subscription_balance_model.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:c4d/module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart';
import 'package:c4d/module_subscription/ui/state/subscription_balance/subcriptions_balance_loaded_state.dart';
import 'package:c4d/module_subscription/ui/state/subscription_balance/subscription_balance_error.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SubscriptionBalanceStateManager {
  final SubscriptionService _subscriptionService;
  final ProfileService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  final PublishSubject<AsyncSnapshot<Object?>> _captainOffersSubject =
      PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;
  Stream<AsyncSnapshot<Object?>> get captainOffersStream =>
      _captainOffersSubject.stream;

  SubscriptionBalanceStateManager(
    this._subscriptionService,
    this._profileService,
    this._authService,
    this._uploadService,
  );
  void getBalance(SubscriptionBalanceScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _subscriptionService.getSubscriptionBalance().then((value) {
      if (value.hasError) {
        if (S.current.notSubscription != value.error) {
          _stateSubject.add(ErrorState(screenState, onPressed: () {
            getBalance(screenState);
          }, title: S.current.mySubscription, error: value.error));
        } else {
          _stateSubject.add(SubscriptionErrorLoadedState(screenState,
              error: value.error ?? S.current.notSubscription));
        }
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getBalance(screenState);
        },
            title: S.current.mySubscription,
            emptyMessage: S.current.homeDataEmpty));
      } else {
        value as SubscriptionBalanceModel;
        _stateSubject
            .add(SubscriptionBalanceLoadedState(screenState, value.data));
      }
    });
  }

  void subscribePackage(
      SubscriptionBalanceScreenState screenState, int packageId) {
    _stateSubject.add(LoadingState(screenState));
    _subscriptionService.subscribePackage(packageId).then((value) {
      if (value.hasError) {
        getBalance(screenState);
        getIt<GlobalStateManager>().update();
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        getBalance(screenState);
        getIt<GlobalStateManager>().update();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.successRenew)
            .show(screenState.context);
      }
    });
  }

  void extendPackage(SubscriptionBalanceScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _subscriptionService.extendPackage().then((value) {
      if (value.hasError) {
        getBalance(screenState);
        getIt<GlobalStateManager>().update();
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        getBalance(screenState);
        getIt<GlobalStateManager>().update();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.packageExtendedSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void getCaptainOffers(SubscriptionBalanceScreenState screenState) {
    _captainOffersSubject.add(AsyncSnapshot.waiting());
    _subscriptionService.getCaptainsOffers().then((value) {
      if (value.hasError) {
        _captainOffersSubject.add(AsyncSnapshot.waiting());
      } else if (value.isEmpty) {
        _captainOffersSubject.add(AsyncSnapshot.nothing());
      } else {
        CaptainsOffersModel model = value as CaptainsOffersModel;
        _captainOffersSubject
            .add(AsyncSnapshot.withData(ConnectionState.done, model.data));
      }
    });
  }

  void subscribeToCaptainOffer(
      SubscriptionBalanceScreenState screenState, int offerID) {
    _stateSubject.add(LoadingState(screenState));
    _subscriptionService.subscribeToCaptainOffer(offerID).then((value) {
      if (value.hasError) {
        getBalance(screenState);
        getCaptainOffers(screenState);
        getIt<GlobalStateManager>().update();
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            .show(screenState.context);
      } else {
        getBalance(screenState);
        getCaptainOffers(screenState);
        getIt<GlobalStateManager>().update();
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.subscribedToOfferSuccess)
            .show(screenState.context);
      }
    });
  }
}
