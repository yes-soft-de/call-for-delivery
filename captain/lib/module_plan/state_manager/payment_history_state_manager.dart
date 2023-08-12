import 'package:c4d/abstracts/states/empty_state.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/payment_history_model.dart';
import 'package:c4d/module_plan/request/payment_history_request.dart';
import 'package:c4d/module_plan/service/plan_service.dart';
import 'package:c4d/module_plan/ui/screen/payment_history_screen.dart';
import 'package:c4d/module_plan/ui/state/payment_history/payment_history_state_loaded.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@injectable
class PaymentHistoryStateManager {
  final stateSubject = PublishSubject<States>();
  final PlanService _planService;

  PaymentHistoryStateManager(this._planService);
  Stream<States> get stateStream => stateSubject.stream;

  void getPaymentHistory(
      PaymentHistoryScreenState screenState, PaymentHistoryRequest request) {
    stateSubject.add(LoadingState(screenState));
    _planService.getPaymentHistory(request).then((value) {
      if (value.hasError) {
        stateSubject.add(
          ErrorState(screenState, onPressed: () {
            getPaymentHistory(screenState, request);
          }, hasAppbar: false, title: S.current.myBalance, error: value.error),
        );
      } else if (value.isEmpty) {
        stateSubject.add(EmptyState(screenState,
            emptyMessage: S.current.homeDataEmpty,
            title: S.current.myBalance, onPressed: () {
          getPaymentHistory(screenState, request);
        }, hasAppbar: false));
      } else {
        value as PaymentHistoryModel;
        stateSubject.add(PaymentHistoryStateLoaded(screenState, value.data));
      }
    });
  }
}
