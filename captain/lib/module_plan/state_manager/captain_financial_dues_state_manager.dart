import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_financial_dues.dart';
import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_plan/ui/screen/captain_financial_dues_screen.dart';
import 'package:c4d/module_plan/ui/state/captain_financial_dues_state/captain_financial_dues_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainFinancialDuesStateManager extends StateManagerHandler {
  final PlanService _planService;

  CaptainFinancialDuesStateManager(this._planService);
  Stream<States> get stateStream => stateSubject.stream;
  void getAccountBalance(CaptainFinancialDuesScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _planService.getCaptainFinancialDues().then((value) {
      if (value.hasError) {
        stateSubject.add(
          ErrorState(screenState, onPressed: () {
            getAccountBalance(screenState);
          }, title: S.current.myBalance, error: value.error, hasAppbar: false),
        );
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            hasAppbar: false,
            title: S.current.myBalance, onPressed: () {
          getAccountBalance(screenState);
        }));
      } else {
        value as CaptainFinancialDuesModel;
        stateSubject
            .add(CaptainFinancialDuesStateLoaded(screenState, value.data));
      }
    });
  }
}
