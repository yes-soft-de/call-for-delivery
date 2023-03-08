import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_payments/model/captain_all_amount_model.dart';
import 'package:c4d/module_payments/request/captain_daily_payment_request.dart';
import 'package:c4d/module_payments/ui/screen/all_amount_captains_screen.dart';
import 'package:c4d/module_payments/ui/widget/paymetns_widget.dart';
import 'package:flutter/material.dart';

class AllAmountCaptainsLoadedState extends States {
  final AllAmountCaptainsScreenState screenState;
  final List<CaptainAllAmountModel> model;
  final String? error;
  final bool empty;

  AllAmountCaptainsLoadedState(this.screenState, this.model,
      {this.error, this.empty = false})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (context, index) {
                return PaymentsWidget(
                  amount: model[index].amount ?? 0,
                  note: model[index].note,
                  // paymentDate: model[index].createdAt ?? DateTime.now(),
                  onEdit: (id, amount, note) {
                    screenState.manager.updatePayments(
                        screenState,
                        CaptainDailyPaymentsRequest(
                          amount: amount,
                          note: note,
                          paymentID: id,
                        ));
                  },
                  id: model[index].id ?? 0,
                  delete: (id) {
                    // Navigator.of(context).pop();
                    screenState.manager.deletePayment(screenState,
                        CaptainDailyPaymentsRequest(paymentID: id));
                  },
                );
              },
            ),
          )

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
