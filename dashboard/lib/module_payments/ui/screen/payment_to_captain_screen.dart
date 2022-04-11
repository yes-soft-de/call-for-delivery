import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_payments/state_manager/payments_to_state_manager.dart';

@injectable
class PaymentsToCaptainScreen extends StatefulWidget {
  final PaymentsToCaptainStateManager _stateManager;

  PaymentsToCaptainScreen(this._stateManager);

  @override
  PaymentsToCaptainScreenState createState() => PaymentsToCaptainScreenState();
}

class PaymentsToCaptainScreenState extends State<PaymentsToCaptainScreen> {
  late States currentState;
  int captainId = -1;
  @override
  void initState() {
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      refresh();
    });
    super.initState();
  }

  void getPayments() {
    widget._stateManager.getCaptainPaymentsDetails(this, captainId);
  }

  void pay(CaptainPaymentsRequest request) {
    widget._stateManager.makePayments(this, request);
  }

  void deletePay(String id) {
    widget._stateManager.deletePayment(this, id);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    if (captainId == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is int) {
        captainId = arg;
        widget._stateManager.getCaptainPaymentsDetails(this, captainId);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).payments),
      body: currentState.getUI(context),
    );
  }
}
