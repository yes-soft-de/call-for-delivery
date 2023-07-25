import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/model/captain_dues_model.dart';
import 'package:c4d/module_captain/request/captain_daily_finance_request.dart';
import 'package:c4d/module_captain/service/captains_service.dart';
import 'package:c4d/module_captain/ui/screen/captain_dues_screen.dart';
import 'package:c4d/module_captain/ui/state/captain_dues_loaded_state.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';

@injectable
class CaptainDuesStateManager {
  final stateSubject = PublishSubject<States>();
  final CaptainsService _planService;
  CaptainDuesStateManager(this._planService);
  Stream<States> get stateStream => stateSubject.stream;

  // void getCaptainsFinanceDaily(CaptainFinanceDailyScreenState screenState) {
  //   stateSubject.add(LoadingState(screenState));
  //   _planService.getCaptainFinanceDaily().then((value) {
  //     if (value.hasError) {
  //       stateSubject.add(CaptainFinanceDailyLoadedState(screenState, null,
  //           error: value.error));
  //     } else if (value.isEmpty) {
  //       stateSubject.add(CaptainFinanceDailyLoadedState(screenState, null,
  //           empty: value.isEmpty));
  //     } else {
  //       CaptainFinanceDailyModel _model = value as CaptainFinanceDailyModel;
  //       stateSubject
  //           .add(CaptainFinanceDailyLoadedState(screenState, _model.data));
  //     }
  //   });
  // }
  void getCaptainsFinanceDailyNew(
      CaptainDuesScreenState screenState, CaptainDailyFinanceRequest request) {
    stateSubject.add(LoadingState(screenState));
    _planService.getCaptainFinanceDailyNew(request).then((value) {
      if (value.hasError) {
        stateSubject
            .add(CaptainDuesLoadedState(screenState, null, error: value.error));
      } else if (value.isEmpty) {
        stateSubject.add(
            CaptainDuesLoadedState(screenState, null, empty: value.isEmpty));
      } else {
        CaptainDuesModel _model = value as CaptainDuesModel;
        stateSubject.add(CaptainDuesLoadedState(screenState, _model.data));
      }
    });
  }
}
