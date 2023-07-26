import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_payments/model/captain_previous_payments_model.dart';
import 'package:c4d/module_payments/request/captain_previous_payments_request.dart';
import 'package:c4d/module_payments/request/payment/paymnet_status_request.dart';
import 'package:c4d/module_payments/state_manager/captain_previous_payments.dart';
import 'package:c4d/module_payments/ui/state/captain_previous_payments/captain_previous_payments_state_loaded.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainPreviousPaymentsScreen extends StatefulWidget {
  final CaptainPreviousPaymentsStateManager _stateManager;

  const CaptainPreviousPaymentsScreen(this._stateManager);

  @override
  State<CaptainPreviousPaymentsScreen> createState() =>
      CaptainPreviousPaymentsScreenState();
}

class CaptainPreviousPaymentsScreenState
    extends State<CaptainPreviousPaymentsScreen> {
  late States _currentState;
  late StreamSubscription _streamSubscription;
  late int captainId;

  @override
  void initState() {
    _currentState = LoadingState(this);

    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void getReceipts(CaptainPreviousPaymentRequest request) {
    request.copyWith(captainId: captainId);
    // widget._stateManager.getReceipts(
    //   this,
    //   request,
    // );
  }

  void makePayment(PaymentStatusRequest request, Function onSuccess) {
    // widget._stateManager.makePayment(this, request, onSuccess);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  bool flag = true;

  @override
  Widget build(BuildContext context) {
    if (flag) {
      flag = false;
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args is List) {
        captainId = args[0];
      }
      var model = CaptainPreviousPaymentsModel(
        ePayments: [
          EPaymentModel(
            amount: 10,
            createdAt: DateTime.now(),
            createdBy: 1,
            details: 'no d',
            id: 1,
            paymentFor: 123,
            paymentGetaway: 123,
            paymentType: 123,
          ),
        ],
        hasTpPay: true,
        subscriptionCost: 123.45,
      );
      var request = CaptainPreviousPaymentRequest(
        captainId: captainId,
      );
      _currentState = CaptainPreviousPaymentsStateLoaded(this, model, request);
      // TODO: call the api
      // getReceipts(ReceiptsRequest(storeOwnerProfileId: storeProfileModel.id));
    }
    return Scaffold(body: _currentState.getUI(context));
  }
}
