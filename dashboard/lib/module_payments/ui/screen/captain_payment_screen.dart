import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/request/captain_payment_request.dart';
import 'package:c4d/module_payments/request/add_payment_to_captain_request.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/state_manager/captain_payment_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class CaptainPaymentScreen extends StatefulWidget {
  const CaptainPaymentScreen();

  @override
  State<StatefulWidget> createState() => CaptainPaymentScreenState();
}

class CaptainPaymentScreenState extends State<CaptainPaymentScreen> {
  late States currentState;
  late CaptainPaymentStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void addPayment(AddPaymentToCaptainRequest request) {
    var actualRequest = CaptainPaymentsRequest(
      captainId: captainID,
      amount: request.amount,
      captainFinancialDuesId: request.captainFinancialDuesId,
      paymentFor: PaymentFor.captainDues,
      paymentGetaway: request.type == CaptainPaymentType.bankTransfer
          ? PaymentGetaway.tapPayment
          : PaymentGetaway.manual,
      paymentType: PaymentType.realPaymentByAdmin,
    );
    _stateManager.addPayment(this, actualRequest);
  }

  void getCaptainPaymentsDetails() {
    _stateManager.getCaptainPaymentsDetails(this, captainID);
  }

  CaptainPaymentStateManager get manager => _stateManager;

  @override
  void initState() {
    currentState = LoadingState(this);
    paymentsFilter = CaptainPaymentRequest();
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  late CaptainPaymentRequest paymentsFilter;
  int captainID = -1;
  String captainName = '';

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List && flag) {
      flag = false;
      captainID = args[0];
      captainName = args[1];
      getCaptainPaymentsDetails();
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: captainName + ' (${captainID})',
      ),
      body: currentState.getUI(context),
    );
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }
}
