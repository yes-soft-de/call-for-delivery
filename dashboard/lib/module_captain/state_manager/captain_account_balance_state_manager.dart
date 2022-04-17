import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_balance_model.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captain_account_balance_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_account_balance/captain_account_balance_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class AccountBalanceStateManager {
  final stateSubject = PublishSubject<States>();
  final CaptainsService _planService;

  AccountBalanceStateManager(this._planService);
  Stream<States> get stateStream => stateSubject.stream;
  void getAccountBalance(CaptainAccountBalanceScreenState screenState,int captainID) {
    stateSubject.add(LoadingState(screenState));
    _planService.getCaptainAccountBalance(captainID).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(screenState, onPressed: () {
          getAccountBalance(screenState,captainID);
        }, title: S.current.myBalance));
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            title: S.current.myBalance, onPressed: () {
          getAccountBalance(screenState,captainID);
        }));
      } else {
        value as CaptainAccountBalanceModel;
        stateSubject.add(AccountBalanceStateLoaded(screenState,value.data));
      }
    });
  }
}
