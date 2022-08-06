import 'package:c4d/module_payments/model/captain_balance_model.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
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

  final _amount = TextEditingController();
  final _note = TextEditingController();
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
        child: CustomListView.custom(
      padding: EdgeInsets.only(left: 16, right: 16),
      children: [
        // Padding(
        //   padding: const EdgeInsets.only(
        //       left: 12.0, bottom: 8, right: 12, top: 16.0),
        //   child: Align(
        //     alignment: AlignmentDirectional.centerStart,
        //     child: Text(
        //       S.current.paymentAmount,
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //       textAlign: TextAlign.start,
        //     ),
        //   ),
        // ),
        // CustomFormField(
        //   controller: _amount,
        //   hintText: S.current.paymentAmount,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(
        //       left: 12.0, bottom: 8, right: 12, top: 16.0),
        //   child: Align(
        //     alignment: AlignmentDirectional.centerStart,
        //     child: Text(
        //       S.current.note,
        //       style: TextStyle(fontWeight: FontWeight.bold),
        //       textAlign: TextAlign.start,
        //     ),
        //   ),
        // ),
        // CustomFormField(
        //   controller: _note,
        //   hintText: S.current.note,
        //   last: true,
        // ),
        // SizedBox(
        //   height: 16,
        // ),
        // ElevatedButton(
        //     onPressed: () {
        //       screenState.pay(CaptainPaymentsRequest(
        //           captainId: screenState.captainId,
        //           note: _note.text,
        //           amount: num.parse(_amount.text.trim())));
        //     },
        //     style: ElevatedButton.styleFrom(
        //       onSurface: Theme.of(context).primaryColor,
        //       elevation: 2,
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(25),
        //       ),
        //     ),
        //     child: Center(
        //       child: Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: Text(
        //           S.current.pay,
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //       ),
        //     )),
        // SizedBox(
        //   height: 16,
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 32.0, left: 32),
        //   child: Divider(
        //     thickness: 2.5,
        //     color: Theme.of(context).backgroundColor,
        //   ),
        // ),

        SizedBox(
          height: 16,
        ),
        getCaptainPaymentFrom(),
        SizedBox(
          height: 16,
        ),
      ],
    ));
  }

  Widget getCaptainPaymentFrom() {
    List<Widget> widgets = [];
    // widgets.add(
    //   Center(
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Text(
    //         S.current.captainPayments,
    //         style: TextStyle(
    //           fontWeight: FontWeight.bold,
    //         ),
    //       ),
    //     ),
    //   ),
    // );

    balanceModel?.paymentsToCaptain.forEach((element) {
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
                                      screenState
                                          .deletePay(element.id.toString());
                                    },
                                    oneAction: false,
                                    content: S
                                        .current.areYouSureToDeleteThisPayment);
                              });
                        },
                        icon: Icon(Icons.delete)),
                  ],
                ),
              ),
            )),
      ));
    });
    return Column(
      children: widgets,
    );
  }
}
