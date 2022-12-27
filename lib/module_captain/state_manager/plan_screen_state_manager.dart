import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/request/captain_finance_request.dart';
import 'package:c4d/module_captain/ui/screen/change_captain_plan_screen.dart';
import 'package:c4d/module_captain/ui/state/init_plan_state_loaded.dart';
import 'package:c4d/module_payments/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_payments/service/payments_service.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class PlanScreenStateManager {
  final stateSubject = PublishSubject<States>();
  final PaymentsService _paymentsService;

  PlanScreenStateManager(this._paymentsService);
  Stream<States> get stateStream => stateSubject.stream;

  void getFinanceCaptainByOrder(PlanScreenState screenState) {
    _paymentsService.getCaptainFinanceByOrder().then((value) {
      if (value.hasError) {
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: null,
            financeByOrder: null,
            financeByOrderCount: null,
            error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: [],
            financeByOrder: [],
            financeByOrderCount: [],
            error: S.current.homeDataEmpty));
      } else {
        value as CaptainFinanceByOrderModel;
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: null,
            financeByOrder: value.data,
            financeByOrderCount: null,
            error: value.error));
      }
    });
  }

  void getFinanceCaptainByHours(PlanScreenState screenState) {
    _paymentsService.getCaptainFinanceByHour().then((value) {
      if (value.hasError) {
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: null,
            financeByOrder: null,
            financeByOrderCount: null,
            error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: [],
            financeByOrder: [],
            financeByOrderCount: [],
            error: S.current.homeDataEmpty));
      } else {
        value as CaptainFinanceByHoursModel;
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: value.data,
            financeByOrder: null,
            financeByOrderCount: null,
            error: value.error));
      }
    });
  }

  void getFinanceCaptainByOrderCount(PlanScreenState screenState) {
    _paymentsService.getCaptainFinanceByOrderCounts().then((value) {
      if (value.hasError) {
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: null,
            financeByOrder: null,
            financeByOrderCount: null,
            error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: [],
            financeByOrder: [],
            financeByOrderCount: [],
            error: S.current.homeDataEmpty));
      } else {
        value as CaptainFinanceByOrdersCountModel;
        stateSubject.add(InitCaptainPlanLoadedState(screenState,
            financeByHours: null,
            financeByOrder: null,
            financeByOrderCount: value.data,
            error: value.error));
      }
    });
  }

  void getFinance(PlanScreenState screenState, String selectedPlan) {
    if (selectedPlan == S.current.financeByOrders) {
      return getFinanceCaptainByOrderCount(screenState);
    } else if (selectedPlan == S.current.financeByHours) {
      return getFinanceCaptainByHours(screenState);
    } else {
      return getFinanceCaptainByOrder(screenState);
    }
  }

  void financeRequest(
      PlanScreenState screenState, CaptainFinanceRequest request) {
    stateSubject.add(LoadingState(screenState));
    _paymentsService.financeRequest(request).then((value) {
      if (value.hasError) {
        screenState.selectedPlan = null;
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
        stateSubject.add(InitCaptainPlanLoadedState(
          screenState,
          financeByHours: null,
          financeByOrder: null,
          financeByOrderCount: null,
        ));
      } else {
        getIt<GlobalStateManager>().updateList();
        Navigator.of(screenState.context).pop();
      }
    });
  }
}
