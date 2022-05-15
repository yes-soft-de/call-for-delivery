import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/ui/screen/account_balance_screen.dart';
import 'package:c4d/module_plan/ui/state/account_balance/account_balance_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:c4d/module_plan/service/plan_service.dart';

@injectable
class AccountBalanceStateManager {
  final stateSubject = PublishSubject<States>();
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
}
