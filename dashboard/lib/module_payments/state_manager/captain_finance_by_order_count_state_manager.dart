import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_count_order_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_count_screen.dart';
import 'package:c4d/module_payments/ui/state/captain_finance/captain_finance_by_order_count.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';

@injectable
class CaptainFinanceByOrderCountStateManager extends StateManagerHandler {
  final PaymentsService _storePaymentsService;

  Stream<States> get stateStream => stateSubject.stream;

  CaptainFinanceByOrderCountStateManager(this._storePaymentsService);

  void getFinances(CaptainFinanceByCountOrderScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.getCaptainFinanceByOrderCounts().then((value) {
      if (value.hasError) {
        stateSubject.add(CaptainFinanceByOrderCountLoadedState(
          screenState,
          null,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        stateSubject.add(CaptainFinanceByOrderCountLoadedState(
            screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainFinanceByOrdersCountModel _balance =
            value as CaptainFinanceByOrdersCountModel;
        stateSubject.add(
            CaptainFinanceByOrderCountLoadedState(screenState, _balance.data));
      }
    });
  }

  void createFinance(CaptainFinanceByCountOrderScreenState screenState,
      CreateCaptainFinanceByCountOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService
        .createCaptainFinanceByOrderCounts(request)
        .then((value) {
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

  void updateFinance(CaptainFinanceByCountOrderScreenState screenState,
      CreateCaptainFinanceByCountOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService
        .updateCaptainFinanceByOrderCounts(request)
        .then((value) {
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

  void deleteFinance(
      CaptainFinanceByCountOrderScreenState screenState, int id) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.deleteCaptainFinanceByOrderCounts(id).then((value) {
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
