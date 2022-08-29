import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_offer_model.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_categories/model/packages_model.dart';
import 'package:c4d/module_subscriptions/request/store_captain_offer_request.dart';
import 'package:c4d/module_subscriptions/request/store_subscribe_to_package.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/subscription_to_captain_offer_screen.dart';
import 'package:c4d/module_subscriptions/ui/state/subscribe_to_captain_offer/subscribe_to_captain_offer_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SubscriptionToCaptainOfferStateManager {
  final SubscriptionsService _initAccountService;
  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  SubscriptionToCaptainOfferStateManager(
    this._initAccountService,
  );
  void getPackages(
    CreateSubscriptionToCaptainOfferScreenState screenState,
  ) {
    getIt<CaptainsService>().getCaptainOffer().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getPackages(screenState);
        }, title: S.current.captainOffer, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getPackages(screenState);
        },
            title: S.current.captainOffer,
            emptyMessage: S.current.homeDataEmpty));
      } else {
        value as CaptainsOffersModel;
        _stateSubject
            .add(SubscribeToCaptainOfferLoadedState(screenState, value.data));
      }
    });
  }

  void subscribePackage(CreateSubscriptionToCaptainOfferScreenState screenState,
      StoreSubscribeToCaptainOfferRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _initAccountService.subscribeToCaptainOffer(request).then((value) {
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
