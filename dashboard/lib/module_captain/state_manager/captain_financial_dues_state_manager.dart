import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_financial_dues.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captain_financial_dues_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_financial_dues_state/captain_financial_dues_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class CaptainFinancialDuesStateManager {
  final stateSubject = PublishSubject<States>();
  final CaptainsService _captainService;

  CaptainFinancialDuesStateManager(this._captainService);
  Stream<States> get stateStream => stateSubject.stream;
  void getAccountBalance(
      CaptainFinancialDuesScreenState screenState, int captainID,
      [bool loading = true]) {
    if (loading) {
      stateSubject.add(LoadingState(screenState));
    }
    _captainService.getCaptainFinancialDues(captainID).then((value) {
      if (value.hasError) {
        stateSubject.add(
          ErrorState(screenState, onPressed: () {
            getAccountBalance(screenState, captainID);
          }, title: S.current.myBalance, error: value.error, hasAppbar: false),
        );
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            hasAppbar: false,
            title: S.current.myBalance, onPressed: () {
          getAccountBalance(screenState, captainID);
        }));
      } else {
        value as CaptainFinancialDuesModel;
        stateSubject
            .add(CaptainFinancialDuesStateLoaded(screenState, value.data));
      }
    });
  }
}
