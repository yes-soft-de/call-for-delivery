import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_plan/ui/screen/account_balance_screen.dart';
import 'package:c4d/module_plan/ui/state/account_balance/account_balance_loaded_state.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class AccountBalanceStateManager extends StateManagerHandler {
  final PlanService _planService;

  AccountBalanceStateManager(this._planService);
  Stream<States> get stateStream => stateSubject.stream;
  void getAccountBalance(AccountBalanceScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _planService.getCaptainAccountBalance().then((value) {
      if (value.hasError) {
        stateSubject.add(
          ErrorState(screenState, onPressed: () {
            getAccountBalance(screenState);
          }, hasAppbar: false, title: S.current.myBalance, error: value.error),
        );
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            title: S.current.myBalance, onPressed: () {
          getAccountBalance(screenState);
        }, hasAppbar: false));
      } else {
        value as CaptainAccountBalanceModel;
        stateSubject.add(AccountBalanceStateLoaded(screenState, value.data));
      }
    });
  }

  void stopeCurrentAccountPlan(AccountBalanceScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _planService.stopCaptainFinancialDues().then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
        getAccountBalance(screenState);
      } else {
        CustomFlushBarHelper.createSuccess(
                title: S.current.warnning,
                message: S.current.yourCurrentPlanStoppedSuccessfully)
            .show(screenState.context);
        getAccountBalance(screenState);
      }
    });
  }
}
