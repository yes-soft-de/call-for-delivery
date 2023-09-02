import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_captain/request/captain_payment_request.dart';
import 'package:c4d/module_payments/state_manager/captain_payment_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AllAmountCaptainsScreen extends StatefulWidget {
  const AllAmountCaptainsScreen();

  @override
  State<StatefulWidget> createState() => AllAmountCaptainsScreenState();
}

class AllAmountCaptainsScreenState extends State<AllAmountCaptainsScreen> {
  late States currentState;
  late CaptainPaymentStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  CaptainPaymentStateManager get manager => _stateManager;
  var today = DateTime.now();
  @override
  void initState() {
    currentState = LoadingState(this);
    paymentsFilter = CaptainPaymentRequest(captainProfileId: captainID);
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
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List && flag) {
      captainID = args[0];
      flag = false;
      paymentsFilter.captainProfileId = captainID;
      _stateManager.getAllAmount(this, paymentsFilter);
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(
          context,
          title: '',
          icon: Icons.cancel,
        ),
        body: currentState.getUI(context));
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }
}
