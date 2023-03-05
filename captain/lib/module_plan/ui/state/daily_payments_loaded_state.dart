import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_plan/ui/screen/daily_payments_screen.dart';
import 'package:c4d/module_profile/model/daily_model.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:intl/intl.dart' as intl;

class DailyPaymentsLoaded extends States {
  final DailyPaymentsScreenState screenState;
  final DailyFinanceModel model;
  final String? error;
  final bool empty;

  DailyPaymentsLoaded(this.screenState, this.model,
      {this.error, this.empty = false})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomListView.custom(children: getStorePaymentFrom()),
    );
  }

  List<Widget> getStorePaymentFrom() {
    List<Widget> widgets = [];
    model.payments.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(screenState.context).backgroundColor,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onTap: element.note != null
                  ? () {
                      showDialog(
                          context: screenState.context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              title: Text(S.current.note),
                              content: Container(
                                child: Text(element.note ?? ''),
                              ),
                            );
                          });
                    }
                  : null,
              leading: const Icon(Icons.credit_card_rounded),
              title: Text(S.current.paymentAmount),
              subtitle: Text(element.amount.toStringAsFixed(1)),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Text(intl.DateFormat('yyyy/M/dd')
                        .format(element.paymentDate)),
                    const SizedBox(
                      width: 16,
                    ),
                    Visibility(
                      visible: false,
                      child: IconButton(
                          splashRadius: 15,
                          onPressed: () {
                            showDialog(
                                context: screenState.context,
                                builder: (context) {
                                  return CustomAlertDialog(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      content: S.current
                                          .areYouSureToDeleteThisPayment);
                                });
                          },
                          icon: const Icon(Icons.delete)),
                    ),
                  ],
                ),
              ),
            )),
      ));
    });
    if (widgets.isEmpty) {
      widgets.add(EmptyStateWidget(
        empty: S.current.homeDataEmpty,
        onRefresh: null,
        height: 100,
      ));
    }
    return widgets;
  }
}
