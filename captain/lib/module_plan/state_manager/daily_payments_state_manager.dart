import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_plan/model/captain_daily_finance_model.dart';
import 'package:c4d/module_plan/ui/screen/daily_payments_screen.dart';
import 'package:c4d/module_plan/ui/state/daily_payments_loaded_state.dart';
import 'package:c4d/module_profile/model/captain_balance_model.dart';
import 'package:c4d/module_profile/model/daily_model.dart';
import 'package:c4d/module_profile/request/captain_payments_request.dart';
import 'package:c4d/module_profile/service/profile/profile.service.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class DailyBalanceStateManager {
  final ProfileService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  DailyBalanceStateManager(
    this._profileService,
    this._authService,
    this._uploadService,
  );
  void getAccountBalance(
      DailyPaymentsScreenState screenState, CaptainPaymentRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _profileService.getDailyPayments(request).then((value) {
      if (value.hasError) {
        _stateSubject.add(ErrorState(screenState, onPressed: () {
          getAccountBalance(screenState, request);
        }, title: S.current.payments));
      } else if (value.isEmpty) {
        _stateSubject.add(EmptyState(screenState, onPressed: () {
          getAccountBalance(screenState, request);
        }, title: S.current.payments, emptyMessage: S.current.emptyStaff));
      } else {
        CaptainDailyFinanceModel captain = value as CaptainDailyFinanceModel;
        _stateSubject.add(DailyPaymentsLoaded(screenState, captain.data));
      }
    });
  }
}
