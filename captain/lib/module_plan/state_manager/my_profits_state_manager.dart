import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_plan/ui/screen/my_profits_screen.dart';
import 'package:c4d/module_plan/ui/state/my_profits/my_profits_state_loaded.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class MyProfitsStateManager {
  final stateSubject = PublishSubject<States>();
  final PlanService _planService;

  MyProfitsStateManager(this._planService);
  Stream<States> get stateStream => stateSubject.stream;

  void getAccountBalance(MyProfitsScreenState screenState) {
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
        // stateSubject.add(MyProfitsStateLoaded(screenState, value.data));
      }
    });
  }
}
