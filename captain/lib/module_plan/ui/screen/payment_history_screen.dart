import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/payment_history_model.dart';
import 'package:c4d/module_plan/request/payment_history_request.dart';
import 'package:c4d/module_plan/state_manager/payment_history_state_manager.dart';
import 'package:c4d/module_plan/ui/state/payment_history/payment_history_state_loaded.dart';
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
  States? _currentState;
  late final PaymentHistoryRequest request;

  @override
  void initState() {
    var model = PaymentHistoryModel(
      ePayments: [
        EPaymentModel(
          amount: 123.45,
          createdAt: DateTime.now(),
          createdBy: 1,
          details: '',
          id: 1,
          paymentFor: 2,
          paymentGetaway: 236,
          paymentType: 3,
        ),
        EPaymentModel(
          amount: 678.99,
          createdAt: DateTime.now(),
          createdBy: 1,
          details: '',
          id: 1,
          paymentFor: 2,
          paymentGetaway: 3,
          paymentType: 2,
        ),
      ],
      hasTpPay: false,
      subscriptionCost: 390,
    );
    request = PaymentHistoryRequest(
      storeOwnerProfileId: 13,
      customizedTimezone: '',
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
    );
    _currentState = PaymentHistoryStateLoaded(this, model);
    widget._manager.stateSubject.listen((value) {
      _currentState = value;
      if (mounted) setState(() {});
    });
    super.initState();
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
                    request.copyWith(fromDate: selectedDate);
                  },
                ),
              ),
              Flexible(
                child: SelectDataBar(
                  onSelected: (selectedDate) {
                    request.copyWith(toDate: selectedDate);
                  },
                  selectedDate: request.toDate,
                  title: S.current.to,
                ),
              ),
            ],
          ),
          _currentState?.getUI(context) ?? Container(),
        ],
      ),
    );
  }
}
