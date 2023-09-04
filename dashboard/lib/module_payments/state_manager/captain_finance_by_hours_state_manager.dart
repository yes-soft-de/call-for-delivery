import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/module_payments/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_hours.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_hours_screen.dart';
import 'package:c4d/module_payments/ui/state/captain_finance/captain_fianance_by_hours_state.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';

@injectable
class CaptainFinanceByHoursStateManager extends StateManagerHandler {
  final PaymentsService _storePaymentsService;

  Stream<States> get stateStream => stateSubject.stream;

  CaptainFinanceByHoursStateManager(this._storePaymentsService);

  void getFinances(CaptainFinanceByHoursScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.getCaptainFinanceByHour().then((value) {
      if (value.hasError) {
        stateSubject.add(CaptainFinanceByHoursLoadedState(
          screenState,
          null,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        stateSubject.add(CaptainFinanceByHoursLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainFinanceByHoursModel _balance =
            value as CaptainFinanceByHoursModel;
        stateSubject
            .add(CaptainFinanceByHoursLoadedState(screenState, _balance.data));
      }
    });
  }

  void createFinance(CaptainFinanceByHoursScreenState screenState,
      CreateCaptainFinanceByHoursRequest request) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.createCaptainFinanceByHour(request).then((value) {
      if (value.hasError) {
        getFinances(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        getFinances(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: value.error ?? S.current.addPackageSuccessfully);
      }
    });
  }

  void updateFinance(CaptainFinanceByHoursScreenState screenState,
      CreateCaptainFinanceByHoursRequest request) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.updateCaptainFinanceByHour(request).then((value) {
      if (value.hasError) {
        getFinances(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        getFinances(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message: value.error ?? S.current.updatePackageSuccessfully);
      }
    });
  }

  void deleteFinance(CaptainFinanceByHoursScreenState screenState, int id) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.deleteCaptainFinanceByHour(id).then((value) {
      if (value.hasError) {
        getFinances(screenState);
        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        getFinances(screenState);
        CustomFlushBarHelper.createSuccess(
            title: S.current.warnning,
            message:
                value.error ?? S.current.financeCategoryDeletedSuccessfully);
      }
    });
  }
}
