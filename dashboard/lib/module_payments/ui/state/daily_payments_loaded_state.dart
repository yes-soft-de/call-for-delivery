import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_daily_finance.dart';
import 'package:c4d/module_payments/payments_routes.dart';
import 'package:c4d/module_payments/request/captain_daily_payment_request.dart';
import 'package:c4d/module_payments/ui/screen/daily_payments_screen.dart';
import 'package:c4d/module_payments/ui/widget/daily_payments_widget.dart';
import 'package:flutter/material.dart';

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
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DailyWidget(
                    alreadyHadAmount: model[index].alreadyHadAmount,
                    amount: model[index].amount,
                    bonus: model[index].bonus,
                    financeSystemPlan: model[index].financialSystemPlan,
                    financeType: model[index].financialSystemType,
                    isPaid: model[index].isPaid,
                    payments: model[index].payments,
                    withBonus: model[index].withBonus,
                    onPay: (amount, note) {
                      screenState.manager.makePayments(
                          screenState,
                          CaptainDailyPaymentsRequest(
                              captainId: model[index].id,
                              amount: amount,
                              note: note));
                    },
                    id: model[index].captainProfileId,
                    createdAt: model[index].createdAt,
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      PaymentsRoutes.ALL_AMOUNT_CAPTAINS,
                      arguments: [screenState.captainID],
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(S.current.showPayments)),
                ),
              ),
            ],
          ),

          // CustomListView.custom(children: getStorePaymentFrom(context))
        ],
      ),
    );
  }

  // List<Widget> getStorePaymentFrom(BuildContext context) {
  //   List<Widget> widgets = [];
  //   for (var model[index] in model) {
  //     widgets.add();
  //       },
  //     ));
  //   }
  // return widgets;
}
// }
