import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/request/payment_history_request.dart';
import 'package:c4d/module_plan/state_manager/payment_history_state_manager.dart';
import 'package:c4d/module_plan/ui/widget/select_date_bar_widget.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentHistoryScreen extends StatefulWidget {
  final PaymentHistoryStateManager _manager;

  const PaymentHistoryScreen(this._manager);

  @override
  State<StatefulWidget> createState() => PaymentHistoryScreenState();
}

class PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  late States _currentState;
  late PaymentHistoryRequest request;

  @override
  void initState() {
    _currentState = LoadingState(this);
    request = PaymentHistoryRequest(
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
    );

    getPaymentHistory(request);

    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  void getPaymentHistory(PaymentHistoryRequest request) {
    widget._manager.getPaymentHistory(this, request);
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
