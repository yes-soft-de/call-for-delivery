import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/module_payments/model/captain_balance_model.dart';
import 'package:c4d/module_payments/ui/screen/payment_to_captain_screen.dart';
import 'package:c4d/module_payments/ui/state/payment_to_captain/captains_payments_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class PaymentsToCaptainStateManager extends StateManagerHandler {
  final PaymentsService _paymentsService;

  Stream<States> get stateStream => stateSubject.stream;

  PaymentsToCaptainStateManager(this._paymentsService);

  void getCaptainPaymentsDetails(
      PaymentsToCaptainScreenState screenState, int captainId) {
    stateSubject.add(LoadingState(screenState));
    _paymentsService.getCaptainBalance(captainId).then((value) {
      if (value.hasError) {
        stateSubject.add(PaymentsToCaptainLoadedState(
          screenState,
          null,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        stateSubject.add(PaymentsToCaptainLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainBalanceModel _balance = value as CaptainBalanceModel;
        stateSubject
            .add(PaymentsToCaptainLoadedState(screenState, _balance.data));
      }
    });
  }

  void makePayments(PaymentsToCaptainScreenState screenState,
      CaptainPaymentsRequest request) {
    stateSubject.add(LoadingState(screenState));
    _paymentsService.paymentToCaptain(request).then((value) {
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

  void deletePayment(PaymentsToCaptainScreenState screenState, String id) {
    stateSubject.add(LoadingState(screenState));
    _paymentsService.deletePaymentToCaptain(id).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString());
        getCaptainPaymentsDetails(screenState, screenState.captainId);
      } else {
        getCaptainPaymentsDetails(screenState, screenState.captainId);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.deleteSuccess);
      }
    });
  }
}
