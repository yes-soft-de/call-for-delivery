import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/payment_history_model.dart';
import 'package:c4d/module_plan/ui/screen/payment_history_screen.dart';
import 'package:c4d/module_plan/ui/widget/payment_card.dart';
import 'package:c4d/module_plan/ui/widget/payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentHistoryStateLoaded extends States {
  final PaymentHistoryScreenState screenState;
  final PaymentHistoryModel model;

  PaymentHistoryStateLoaded(this.screenState, this.model) : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          PaymentWidget(
            model: model,
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: model.payments.length,
            itemBuilder: (context, index) {
              var payment = model.payments[index];
              return PaymentCard(
                paymentValue: S.current
                    .paymentValueRiyal(payment.amount.toStringAsFixed(2)),
                paymentType: PaymentType.fromInt(payment.paymentGetaway),
                date: DateFormat('yyyy/MM/dd', 'en').format(payment.createdAt),
              );
            },
          ),
        ],
      ),
    );
  }
}
