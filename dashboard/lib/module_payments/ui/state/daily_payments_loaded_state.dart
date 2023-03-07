import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_payments/model/captain_daily_finance.dart';
import 'package:c4d/module_payments/request/captain_daily_payment_request.dart';
import 'package:c4d/module_payments/ui/screen/daily_payments_screen.dart';
import 'package:c4d/module_payments/ui/widget/daily_payments_widget.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_list_view.dart';

class DailyPaymentsLoaded extends States {
  final DailyPaymentsScreenState screenState;
  final List<CaptainDailyFinanceModel> model;
  final String? error;
  final bool empty;

  DailyPaymentsLoaded(this.screenState, this.model,
      {this.error, this.empty = false})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomListView.custom(children: getStorePaymentFrom(context)),
    );
  }

  List<Widget> getStorePaymentFrom(BuildContext context) {
    List<Widget> widgets = [];
    for (var element in model) {
      widgets.add(DailyWidget(
        alreadyHadAmount: element.alreadyHadAmount,
        amount: element.amount,
        bonus: element.bonus,
        financeSystemPlan: element.financialSystemPlan,
        financeType: element.financialSystemType,
        isPaid: element.isPaid,
        payments: element.payments,
        withBonus: element.withBonus,
        onPay: (amount, note) {
          screenState.manager.makePayments(
              screenState,
              CaptainDailyPaymentsRequest(
                  captainId: element.id, amount: amount, note: note));
        },
        onDelete: (id) {
          Navigator.of(context).pop();
          screenState.manager.deletePayment(
              screenState, CaptainDailyPaymentsRequest(paymentID: id));
        },
        onEdit: (id, amount, note) {
          Navigator.of(context).pop();
          screenState.manager.updatePayments(
              screenState,
              CaptainDailyPaymentsRequest(
                amount: amount,
                note: note,
                paymentID: id,
              ));
        },
      ));
    }
    return widgets;
  }
}
