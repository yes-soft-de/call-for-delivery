import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_payments/request/add_payment_to_captain_request.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/request/captain_previous_payments_request.dart';
import 'package:c4d/module_payments/state_manager/captain_previous_payments.dart';
import 'package:flutter/material.dart';

class CaptainPreviousPaymentsScreen extends StatefulWidget {
  const CaptainPreviousPaymentsScreen();

  @override
  State<CaptainPreviousPaymentsScreen> createState() =>
      CaptainPreviousPaymentsScreenState();
}

class CaptainPreviousPaymentsScreenState
    extends State<CaptainPreviousPaymentsScreen> {
  late States _currentState;
  late StreamSubscription _streamSubscription;
  late CaptainPreviousPaymentsStateManager _stateManager;

  late int captainId;
  late int captainFinancialDuesId;
  late CaptainPreviousPaymentRequest filter;

  @override
  void initState() {
    _currentState = LoadingState(this);
    _stateManager = getIt();
    _streamSubscription = _stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  void filterCaptainPayment(CaptainPreviousPaymentRequest request) {
    request.copyWith(captainId: captainId);
    _stateManager.filterCaptainPayment(
      this,
      request,
    );
  }

  void addPayment(AddPaymentToCaptainRequest request) {
    var actualRequest = CaptainPaymentsRequest(
      captainId: captainId,
      amount: request.amount,
      captainFinancialDuesId: captainFinancialDuesId,
      paymentFor: PaymentFor.captainDues,
      paymentGetaway: request.type == CaptainPaymentType.bankTransfer
          ? PaymentGetaway.tapPayment
          : PaymentGetaway.manual,
      paymentType: PaymentType.realPaymentByAdmin,
    );
    _stateManager.addPayment(this, actualRequest, filter);
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
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
        captainFinancialDuesId = args[1];
      }

      filter = CaptainPreviousPaymentRequest(
        captainId: captainId,
        captainFinancialDuesId: captainFinancialDuesId,
      );
      filterCaptainPayment(filter);
    }
    return Scaffold(body: _currentState.getUI(context));
  }
}
