import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/request/captain_payment_request.dart';
import 'package:c4d/module_payments/model/captain_all_amount_model.dart';
import 'package:c4d/module_payments/model/captain_daily_finance.dart';
import 'package:c4d/module_payments/model/captain_dues_model.dart';
import 'package:c4d/module_payments/request/captain_daily_payment_request.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_payments/ui/screen/all_amount_captains_screen.dart';
import 'package:c4d/module_payments/ui/screen/captain_payment_screen.dart';
import 'package:c4d/module_payments/ui/state/all_amount_captains_state.dart';
import 'package:c4d/module_payments/ui/state/captain_payment_state_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainPaymentStateManager extends StateManagerHandler {
  final PaymentsService _profileService;

  Stream<States> get stateStream => stateSubject.stream;

  CaptainPaymentStateManager(
    this._profileService,
  );
  void getAccountBalance(
      CaptainPaymentScreenState screenState, CaptainPaymentRequest request) {
    stateSubject.add(LoadingState(screenState));
    _profileService.getCaptainFinanceDaily(request).then((value) {
      if (value.hasError) {
        stateSubject
            .add(ErrorState(screenState, hasAppbar: false, onPressed: () {
          getAccountBalance(screenState, request);
        }, title: S.current.payments));
      } else if (value.isEmpty) {
        stateSubject
            .add(EmptyState(screenState, hasAppbar: false, onPressed: () {
          getAccountBalance(screenState, request);
        }, title: S.current.payments, emptyMessage: S.current.emptyStaff));
      } else {
        CaptainDailyFinanceModel captain = value as CaptainDailyFinanceModel;
        // TODO this function api call need to change
        // _stateSubject.add(CaptainPaymentStateLoaded(screenState, captain.data));
      }
    });
  }

  void getCaptainPaymentsDetails(
      CaptainPaymentScreenState screenState, int captainId) {
    stateSubject.add(LoadingState(screenState));
    _profileService.getCaptainFinance(captainId).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(
          screenState,
          onPressed: () {
            getCaptainPaymentsDetails(screenState, captainId);
          },
          title: '',
          hasAppbar: false,
        ));
      } else if (value.isEmpty) {
        stateSubject
            .add(EmptyState(screenState, hasAppbar: false, onPressed: () {
          getCaptainPaymentsDetails(screenState, captainId);
        }, title: S.current.payments, emptyMessage: S.current.emptyStaff));
      } else {
        CaptainPaymentModel _balance = value as CaptainPaymentModel;
        stateSubject.add(CaptainPaymentStateLoaded(screenState, _balance.data));
      }
    });
  }

  void addPayment(
      CaptainPaymentScreenState screenState, CaptainPaymentsRequest request) {
    stateSubject.add(LoadingState(screenState));
    _profileService.paymentToCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString());
        getCaptainPaymentsDetails(screenState, request.captainId ?? -1);
      } else {
        getCaptainPaymentsDetails(screenState, request.captainId ?? -1);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.paymentSuccessfully);
      }
    });
  }

  void updatePayments(AllAmountCaptainsScreenState screenState,
      CaptainDailyPaymentsRequest request) {
    stateSubject.add(LoadingState(screenState));
    _profileService.editDailyFinance(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString());
        getAllAmount(screenState, screenState.paymentsFilter);
      } else {
        getAllAmount(screenState, screenState.paymentsFilter);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: S.current.updatePaymentSuccessfully);
      }
    });
  }

  void deletePayment(AllAmountCaptainsScreenState screenState,
      CaptainDailyPaymentsRequest request) {
    stateSubject.add(LoadingState(screenState));
    _profileService.deleteDailyFinance(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString());
        getAllAmount(screenState, screenState.paymentsFilter);
        // getAccountBalance(screenState, screenState.paymentsFilter);
      } else {
        getAllAmount(screenState, screenState.paymentsFilter);
        // getAccountBalance(screenState, screenState.paymentsFilter);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.deleteSuccess);
      }
    });
  }

  void getAllAmount(
      AllAmountCaptainsScreenState screenState, CaptainPaymentRequest request) {
    stateSubject.add(LoadingState(screenState));
    _profileService.getAllAmountCaptains(request).then((value) {
      if (value.hasError) {
        stateSubject
            .add(ErrorState(screenState, hasAppbar: false, onPressed: () {
          getAllAmount(screenState, request);
        }, title: S.current.payments));
      } else if (value.isEmpty) {
        stateSubject
            .add(EmptyState(screenState, hasAppbar: false, onPressed: () {
          getAllAmount(screenState, request);
        }, title: S.current.payments, emptyMessage: S.current.emptyStaff));
      } else {
        CaptainAllAmountModel model = value as CaptainAllAmountModel;
        stateSubject.add(AllAmountCaptainsLoadedState(screenState, model.data));
      }
    });
  }
}
