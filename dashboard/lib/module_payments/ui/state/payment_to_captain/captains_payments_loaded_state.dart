import 'package:c4d/module_payments/model/captain_balance_model.dart';
import 'package:intl/intl.dart' as intl;
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/ui/screen/payment_to_captain_screen.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/fixed_container.dart';

class PaymentsToCaptainLoadedState extends States {
  final PaymentsToCaptainScreenState screenState;
  final String? error;
  final bool empty;
  final CaptainBalanceModel? balanceModel;

  PaymentsToCaptainLoadedState(this.screenState, this.balanceModel,
      {this.empty = false, this.error})
      : super(screenState) {
    if (error != null) {
      screenState.refresh();
    }
  }
  String? id;

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getPayments();
        },
        error: error,
      );
    }
    return FixedContainer(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: ListView.builder(
          itemCount: balanceModel?.paymentsToCaptain.length ?? 0,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            if (balanceModel != null) {
              var element = balanceModel!.paymentsToCaptain[index];
              return Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          Theme.of(screenState.context).colorScheme.background,
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
                      leading: Icon(Icons.credit_card_rounded),
                      title: Text(S.current.paymentAmount),
                      subtitle: Text(element.amount.toStringAsFixed(1)),
                      trailing: SizedBox(
                        width: 150,
                        child: Row(
                          children: [
                            Text(intl.DateFormat('yyyy/M/dd')
                                .format(element.paymentDate)),
                            SizedBox(
                              width: 16,
                            ),
                            IconButton(
                                splashRadius: 15,
                                onPressed: () {
                                  showDialog(
                                      context: screenState.context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              screenState.deletePay(
                                                  element.id.toString());
                                            },
                                            oneAction: false,
                                            content: S.current
                                                .areYouSureToDeleteThisPayment);
                                      });
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    )),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
