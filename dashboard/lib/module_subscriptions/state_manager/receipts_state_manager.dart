import 'package:c4d/abstracts/state_manager/state_manager_handler.dart';
import 'package:c4d/abstracts/states/error_state.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscriptions/model/receipts_model.dart';
import 'package:c4d/module_subscriptions/request/payment/paymnet_status_request.dart';
import 'package:c4d/module_subscriptions/request/receiptsRequest.dart';
import 'package:c4d/module_subscriptions/service/subscriptions_service.dart';
import 'package:c4d/module_subscriptions/ui/screen/receipts_screen.dart';
import 'package:c4d/module_subscriptions/ui/state/receipts/receipts_state_loaded.dart';
import 'package:c4d/utils/helpers/custom_flushbar.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReceiptsStateManager extends StateManagerHandler {
  final SubscriptionsService _subscriptionService;

  Stream<States> get stateStream => stateSubject.stream;

  ReceiptsStateManager(
    this._subscriptionService,
  );

  void getReceipts(ReceiptsScreenState screenState, ReceiptsRequest request) {
    stateSubject.add(LoadingState(screenState));
    _subscriptionService.getReceipts(request).then((value) {
      if (value.hasError) {
        stateSubject.add(ErrorState(
          screenState,
          onPressed: () {
            getReceipts(screenState, request);
          },
          title: S.current.receipts,
          error: value.error,
        ));

        CustomFlushBarHelper.createError(
            title: S.current.warnning,
            message: value.error ?? S.current.errorHappened);
      } else {
        value as ReceiptsModel;
        stateSubject.add(ReceiptsStateLoaded(
          screenState,
          value.data,
          request,
        ));
      }
    });
  }

  void makePayment(ReceiptsScreenState screenState,
      PaymentStatusRequest request, Function onSuccess) {
    _subscriptionService.makePayment(request).then(
      (value) {
        if (value.hasError) {
          CustomFlushBarHelper.createError(
              title: S.current.warnning, message: value.error ?? '');
        } else {
          CustomFlushBarHelper.createSuccess(
              title: S.current.warnning,
              message: S.current.paymentSuccessfully);
          onSuccess();
        }
      },
    );
  }
}
