import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/service/auth_service/auth_service.dart';
import 'package:c4d/module_captain/request/captain_daily_finance_request.dart';
import 'package:c4d/module_payments/model/captain_all_amount_model.dart';
import 'package:c4d/module_payments/model/captain_daily_finance.dart';
import 'package:c4d/module_payments/request/captain_daily_payment_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_payments/ui/screen/all_amount_captains_screen.dart';
import 'package:c4d/module_payments/ui/screen/daily_payments_screen.dart';
import 'package:c4d/module_payments/ui/state/all_amount_captains_state.dart';
import 'package:c4d/module_payments/ui/state/daily_payments_loaded_state.dart';
import 'package:c4d/module_upload/service/image_upload/image_upload_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class DailyBalanceStateManager {
  final PaymentsService _profileService;
  final AuthService _authService;
  final ImageUploadService _uploadService;

  final PublishSubject<States> _stateSubject = PublishSubject<States>();

  Stream<States> get stateStream => _stateSubject.stream;

  DailyBalanceStateManager(
    this._profileService,
    this._authService,
    this._uploadService,
  );
  void getAccountBalance(DailyPaymentsScreenState screenState,
      CaptainDailyFinanceRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _profileService.getCaptainFinanceDaily(request).then((value) {
      if (value.hasError) {
        _stateSubject
            .add(ErrorState(screenState, hasAppbar: false, onPressed: () {
          getAccountBalance(screenState, request);
        }, title: S.current.payments));
      } else if (value.isEmpty) {
        _stateSubject
            .add(EmptyState(screenState, hasAppbar: false, onPressed: () {
          getAccountBalance(screenState, request);
        }, title: S.current.payments, emptyMessage: S.current.emptyStaff));
      } else {
        CaptainDailyFinanceModel captain = value as CaptainDailyFinanceModel;
        _stateSubject.add(DailyPaymentsLoaded(screenState, captain.data));
      }
    });
  }

  void makePayments(DailyPaymentsScreenState screenState,
      CaptainDailyPaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _profileService.payDailyFinance(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getAccountBalance(screenState, screenState.paymentsFilter);
      } else {
        getAccountBalance(screenState, screenState.paymentsFilter);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void updatePayments(AllAmountCaptainsScreenState screenState,
      CaptainDailyPaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _profileService.editDailyFinance(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getAllAmount(screenState, screenState.paymentsFilter);
      } else {
        getAllAmount(screenState, screenState.paymentsFilter);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.updatePaymentSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void deletePayment(AllAmountCaptainsScreenState screenState,
      CaptainDailyPaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _profileService.deleteDailyFinance(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getAllAmount(screenState, screenState.paymentsFilter);
        // getAccountBalance(screenState, screenState.paymentsFilter);
      } else {
        getAllAmount(screenState, screenState.paymentsFilter);
        // getAccountBalance(screenState, screenState.paymentsFilter);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.deleteSuccess)
            .show(screenState.context);
      }
    });
  }

  void getAllAmount(AllAmountCaptainsScreenState screenState,
      CaptainDailyFinanceRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _profileService.getAllAmountCaptains(request).then((value) {
      if (value.hasError) {
        _stateSubject
            .add(ErrorState(screenState, hasAppbar: false, onPressed: () {
          getAllAmount(screenState, request);
        }, title: S.current.payments));
      } else if (value.isEmpty) {
        _stateSubject
            .add(EmptyState(screenState, hasAppbar: false, onPressed: () {
          getAllAmount(screenState, request);
        }, title: S.current.payments, emptyMessage: S.current.emptyStaff));
      } else {
        CaptainAllAmountModel model = value as CaptainAllAmountModel;
        _stateSubject
            .add(AllAmountCaptainsLoadedState(screenState, model.data));
      }
    });
  }
}
