import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_plan/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_plan/model/captain_finance_by_order_count.dart';
import 'package:c4d/module_plan/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_plan/request/captain_finance_request.dart';
import 'package:c4d/module_plan/ui/screen/plan_screen.dart';
import 'package:c4d/module_plan/ui/state/init_plan_state_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_plan/service/plan_service.dart';

@injectable
class PlanScreenStateManager {
  final stateSubject = PublishSubject<States>();
  final PlanService _planService;

  PlanScreenStateManager(this._planService);
  Stream<States> get stateStream => stateSubject.stream;

  void getFinanceCaptainByOrder(PlanScreenState screenState) {
    _planService.getCaptainFinanceByOrder().then((value) {
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
    _planService.getCaptainFinanceByHour().then((value) {
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
    _planService.getCaptainFinanceByOrderCounts().then((value) {
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
    if (selectedPlan == S.current.planByOrders) {
      return getFinanceCaptainByOrder(screenState);
    } else if (selectedPlan == S.current.planByHours) {
      return getFinanceCaptainByHours(screenState);
    } else {
      return getFinanceCaptainByOrderCount(screenState);
    }
  }

  void financeRequest(
      PlanScreenState screenState, CaptainFinanceRequest request) {
    stateSubject.add(LoadingState(screenState));
    _planService.financeRequest(request).then((value) {
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
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.pleaseWaitAdministrationToAccept)
            .show(screenState.context);
        Navigator.of(screenState.context).pushNamedAndRemoveUntil(
            OrdersRoutes.CAPTAIN_ORDERS_SCREEN, (route) => false);
      }
    });
  }
}
