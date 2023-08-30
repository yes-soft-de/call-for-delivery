import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_payments/request/create_captain_finance_by_order_request.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_screen.dart';
import 'package:c4d/module_payments/ui/state/captain_finance/captain_finance_by_orders_state.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';

@injectable
class CaptainFinanceByOrderStateManager extends StateManagerHandler{
  final PaymentsService _storePaymentsService;

  Stream<States> get stateStream => stateSubject.stream;

  CaptainFinanceByOrderStateManager(this._storePaymentsService);

  void getFinances(CaptainFinanceByOrderScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.getCaptainFinanceByOrder().then((value) {
      if (value.hasError) {
        stateSubject.add(CaptainFinanceByOrderLoadedState(
          screenState,
          null,
          error: value.error,
        ));
      } else if (value.isEmpty) {
        stateSubject.add(CaptainFinanceByOrderLoadedState(screenState, null,
            empty: value.isEmpty));
      } else {
        CaptainFinanceByOrderModel _balance =
            value as CaptainFinanceByOrderModel;
        stateSubject
            .add(CaptainFinanceByOrderLoadedState(screenState, _balance.data));
      }
    });
  }

  void createFinance(CaptainFinanceByOrderScreenState screenState,
      CreateCaptainFinanceByOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.createCaptainFinanceByOrder(request).then((value) {
      if (value.hasError) {
        getFinances(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            ;
      } else {
        getFinances(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.addPackageSuccessfully)
            ;
      }
    });
  }

  void updateFinance(CaptainFinanceByOrderScreenState screenState,
      CreateCaptainFinanceByOrderRequest request) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.updateCaptainFinanceByOrder(request).then((value) {
      if (value.hasError) {
        getFinances(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            ;
      } else {
        getFinances(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: value.error ?? S.current.updatePackageSuccessfully)
            ;
      }
    });
  }

  void deleteFinance(CaptainFinanceByOrderScreenState screenState, int id) {
    stateSubject.add(LoadingState(screenState));
    _storePaymentsService.deleteCaptainFinanceByOrder(id).then((value) {
      if (value.hasError) {
        getFinances(screenState);
        CustomFlushBarHelper.createError(
                title: S.current.warnning,
                message: value.error ?? S.current.errorHappened)
            ;
      } else {
        getFinances(screenState);
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message:
                    value.error ?? S.current.financeCategoryDeletedSuccessfully)
            ;
      }
    });
  }
}
