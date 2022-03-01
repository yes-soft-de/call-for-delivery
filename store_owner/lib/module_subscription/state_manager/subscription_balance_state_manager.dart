import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_subscription/model/subscription_balance_model.dart';
import 'package:c4d/module_subscription/service/subscription_service.dart';
import 'package:c4d/module_subscription/ui/screens/subscription_balance_screen/subscription_balance_screen.dart';
import 'package:c4d/module_subscription/ui/state/subscription_balance/subcriptions_balance_loaded_state.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class SubscriptionBalanceStateManager {
  final SubscriptionService _initAccountService;
  final ProfileService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  SubscriptionBalanceStateManager(
    this._initAccountService,
    this._profileService,
    this._authService,
    this._uploadService,
  );
  void getBalance(SubscriptionBalanceScreenState screenState) {
    _stateSubject.add(LoadingState(screenState));
    _initAccountService.getSubscriptionBalance().then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getBalance(screenState);
        }, title: S.current.storeAccountInit, error: value.error));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getBalance(screenState);
        },
            title: S.current.storeAccountInit,
            emptyMessage: S.current.homeDataEmpty));
      } else {
        value as SubscriptionBalanceModel;
        _stateSubject
            .add(SubscriptionBalanceLoadedState(screenState, value.data));
      }
    });
  }

}
