import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/request/payment_history_request.dart';
import 'package:c4d/module_plan/state_manager/payment_history_state_manager.dart';
import 'package:c4d/module_plan/ui/widget/select_date_bar_widget.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen();

  @override
  State<StatefulWidget> createState() => PaymentHistoryScreenState();
}

class PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  late States _currentState;
  late PaymentHistoryStateManager _stateManager;
  late StreamSubscription _streamSubscription;

  late PaymentHistoryRequest request;

  @override
  void initState() {
    _currentState = LoadingState(this);
    _stateManager = getIt();
    request = PaymentHistoryRequest(
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
    );

    getPaymentHistory(request);

    _streamSubscription = _stateManager.stateStream.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void getPaymentHistory(PaymentHistoryRequest request) {
    _stateManager.getPaymentHistory(this, request);
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.paymentHistory,
      ),
      body: Column(
        children: [
          // date pickers
          Row(
            children: [
              Flexible(
                child: SelectDataBar(
                  title: S.current.from,
                  selectedDate: request.fromDate,
                  onSelected: (selectedDate) {
                    request = request.copyWith(fromDate: selectedDate);
                    getPaymentHistory(request);
                  },
                ),
              ),
              Flexible(
                child: SelectDataBar(
                  onSelected: (selectedDate) {
                    request = request.copyWith(toDate: selectedDate);
                    getPaymentHistory(request);
                  },
                  selectedDate: request.toDate,
                  title: S.current.to,
                ),
              ),
            ],
          ),
          Flexible(child: _currentState.getUI(context)),
        ],
      ),
    );
  }
}
