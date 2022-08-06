import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/hive/captain_hive_helper.dart';
import 'package:c4d/module_captain/model/captain_financial_dues.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captain_financial_details_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_financial_dues_details/captain_financial_dues_details_state.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';

@injectable
class CaptainFinancialDuesDetailsStateManager {
  final PaymentsService _paymentsService;
  final CaptainsService _captainsService;
  final PublishSubject<States> _stateSubject = PublishSubject();

  Stream<States> get stateStream => _stateSubject.stream;

  CaptainFinancialDuesDetailsStateManager(
      this._paymentsService, this._captainsService);

  void getCaptainPaymentsDetails(
      CaptainFinancialDuesDetailsScreenState screenState) {
    _captainsService
        .getCaptainFinancialDues(CaptainsHiveHelper().getCurrentCaptainID())
        .then((value) {
      if (value.hasError) {
        _stateSubject.add(CaptainFinancialDuesDetailsStateLoaded(screenState));
      } else if (value.isEmpty) {
        _stateSubject.add(CaptainFinancialDuesDetailsStateLoaded(screenState));
      } else {
        value as CaptainFinancialDuesModel;
        screenState.model = value.data
            .firstWhere((element) => element.id == screenState.model.id);
        _stateSubject.add(CaptainFinancialDuesDetailsStateLoaded(screenState));
        screenState.refresh();
      }
    });
  }

  void makePayments(CaptainFinancialDuesDetailsScreenState screenState,
      CaptainPaymentsRequest request) {
    _stateSubject.add(LoadingState(screenState));
    _paymentsService.paymentToCaptain(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getCaptainPaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getCaptainPaymentsDetails(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.paymentSuccessfully)
            .show(screenState.context);
      }
    });
  }

  void deletePayment(
      CaptainFinancialDuesDetailsScreenState screenState, String id) {
    _stateSubject.add(LoadingState(screenState));
    _paymentsService.deletePaymentFROMCaptain(id).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error.toString())
            .show(screenState.context);
        getCaptainPaymentsDetails(screenState);
      } else {
        getIt<GlobalStateManager>().updateList();
        getCaptainPaymentsDetails(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning, message: S.current.deleteSuccess)
            .show(screenState.context);
      }
    });
  }
}
