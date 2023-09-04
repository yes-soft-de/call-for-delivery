import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/my_profits_model.dart';
import 'package:c4d/module_plan/request/request_payment.dart';
import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_plan/ui/screen/my_profits_screen.dart';
import 'package:c4d/module_plan/ui/state/my_profits/my_profits_state_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class MyProfitsStateManager extends StateManagerHandler {
  final PlanService _planService;

  MyProfitsStateManager(this._planService);
  Stream<States> get stateStream => stateSubject.stream;

  void getMyProfit(MyProfitsScreenState screenState) {
    stateSubject.add(LoadingState(screenState));
    _planService.getMyProfit().then((value) {
      if (value.hasError) {
        stateSubject.add(
          ErrorState(screenState, onPressed: () {
            getMyProfit(screenState);
          }, hasAppbar: false, title: S.current.myBalance, error: value.error),
        );
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            title: S.current.myBalance, onPressed: () {
          getMyProfit(screenState);
        }, hasAppbar: false));
      } else {
        value as MyProfitsModel;
        stateSubject.add(MyProfitsStateLoaded(screenState, value.data));
      }
    });
  }

  void requestPayment(
      MyProfitsScreenState screenState, RequestPayment request) {
    _planService.requestPayment(request).then((value) {
      if (value.hasError) {
        CustomFlushBarHelper.createError(
                title: S.current.warnning, message: value.error ?? '')
            .show(screenState.context);
      } else {
        CustomFlushBarHelper.createSuccess(
          title: S.current.warnning,
          message: S.current.requestedSuccessfully,
        ).show(screenState.context);
      }
    });
  }
}
