import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_captain/request/captain_payment_request.dart';
import 'package:c4d/module_payments/model/captain_dues_model.dart';
import 'package:c4d/module_payments/request/add_payment_to_captain_request.dart';
import 'package:c4d/module_payments/state_manager/captain_payment_state_manager.dart';
import 'package:c4d/module_payments/ui/state/captain_payment_state_loaded.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class CaptainPaymentScreen extends StatefulWidget {
  final CaptainPaymentStateManager _stateManager;

  const CaptainPaymentScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => CaptainPaymentScreenState();
}

class CaptainPaymentScreenState extends State<CaptainPaymentScreen> {
  late StreamSubscription _streamSubscription;
  late States currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void addPayment(AddPaymentToCaptainRequest request) {
    request = request.copyWith(captainId: captainID);
    // TODO: call the api
  }

  CaptainPaymentStateManager get manager => widget._stateManager;

  @override
  void initState() {
    currentState = LoadingState(this);
    paymentsFilter = CaptainPaymentRequest();
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
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
      captainID = args[0];
      captainName = args[1];
      flag = false;
      paymentsFilter.captainProfileId = captainID;
      var model = CaptainPaymentModel(
          duesSinceLastPayment: 123.34,
          lastPayment: 567.89,
          lastPaymentDate: DateTime.now(),
          profitsFromOrders: 123.45,
          unpaidAmountsFromCashToStores: 321.54);
      currentState = CaptainPaymentStateLoaded(this, model);
      // TODO: make api call here
      // widget._stateManager.getAccountBalance(this, paymentsFilter);
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
    _streamSubscription.cancel();
    super.dispose();
  }
}
