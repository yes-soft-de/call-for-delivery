import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_previous_payments_model.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/request/captain_previous_payments_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_payments/ui/screen/captain_previous_payments_screen.dart';
import 'package:c4d/module_payments/ui/state/captain_previous_payments/captain_previous_payments_state_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';

@injectable
class CaptainPreviousPaymentsStateManager extends StateManagerHandler {
  final PaymentsService _storePaymentsService;

  Stream<States> get stateStream => stateSubject.stream;

  CaptainPreviousPaymentsStateManager(this._storePaymentsService);

  void filterCaptainPayment(CaptainPreviousPaymentsScreenState screenState,
      CaptainPreviousPaymentRequest request) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.filterCaptainPayment(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(
          screenState,
          error: value.error,
          onPressed: () {
            filterCaptainPayment(screenState, request);
          },
          title: S.current.previousPayments,
        ));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(
          screenState,
          emptyMessage: S.current.emptyStaff,
          title: S.current.previousPayments,
          onPressed: () {
            filterCaptainPayment(screenState, request);
          },
        ));
      } else {
        var _balance = value as CaptainPreviousPaymentsModel;
        stateSubject.add(CaptainPreviousPaymentsStateLoaded(
          screenState,
          _balance.data,
          request,
        ));
      }
    });
  }

  void addPayment(CaptainPreviousPaymentsScreenState screenState,
      CaptainPaymentsRequest request, CaptainPreviousPaymentRequest filter) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.paymentToCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
            title: S.current.warnning, message: value.error.toString());
        filterCaptainPayment(screenState, filter);
      } else {
        filterCaptainPayment(screenState, filter);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning, message: S.current.paymentSuccessfully);
      }
    });
  }
}
