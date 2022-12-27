import 'dart:ui';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/hive/captain_hive_helper.dart';
import 'package:c4d/module_captain/model/captain_financial_dues.dart';
import 'package:c4d/module_captain/ui/screen/captain_financial_details_screen.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CaptainFinancialDuesDetailsStateLoaded extends States {
  final CaptainFinancialDuesDetailsScreenState screenState;
  CaptainFinancialDuesDetailsStateLoaded(this.screenState) : super(screenState);
  late CaptainFinancialDuesModel model;
  TextEditingController _amount = TextEditingController();
  TextEditingController _note = TextEditingController();

  @override
  Widget getUI(BuildContext context) {
    model = screenState.model;
    return CustomListView.custom(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ListTile(
                    horizontalTitleGap: 0,
                    leading: const Icon(Icons.info_rounded),
                    title: Text(S.current.currentFinancialCycleHint +
                        ' ${model.startDate + ' - ' + model.endDate}'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0, left: 16),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  balanceDetails(context),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return AlertDialog(
                          scrollable: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          title: Text(S.current.paymentToCaptain),
                          content: Container(
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(S.current.paymentAmount),
                                  subtitle: CustomFormField(
                                    onChanged: () {
                                      setState(() {});
                                    },
                                    numbers: true,
                                    controller: _amount,
                                    hintText: '100',
                                  ),
                                ),
                                ListTile(
                                  title: Text(S.current.note),
                                  subtitle: CustomFormField(
                                    controller: _note,
                                    hintText: S.current.note,
                                    last: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actionsAlignment: MainAxisAlignment.center,
                          actions: [
                            ElevatedButton(
                                onPressed: _amount.text.isEmpty
                                    ? null
                                    : () {
                                        Navigator.of(context).pop();
                                        screenState.manager.makePayments(
                                            screenState,
                                            CaptainPaymentsRequest(
                                              status: (num.tryParse(_amount.text
                                                              .trim()) ??
                                                          0) >=
                                                      (model.total
                                                              .sumCaptainFinancialDues -
                                                          model.total
                                                              .sumPaymentsToCaptain)
                                                  ? 1
                                                  : 3,
                                              captainFinancialDuesId: model.id,
                                              captainId: CaptainsHiveHelper()
                                                  .getCurrentCaptainID(),
                                              amount: num.tryParse(
                                                      _amount.text.trim()) ??
                                                  0,
                                              note: _note.text,
                                            ));
                                      },
                                child: Text(
                                  S.current.pay,
                                  style: Theme.of(context).textTheme.button,
                                )),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _amount.clear();
                                  _note.clear();
                                },
                                child: Text(
                                  S.current.cancel,
                                  style: Theme.of(context).textTheme.button,
                                ))
                          ],
                        );
                      });
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  S.current.makePayment,
                  style: Theme.of(context).textTheme.button,
                ),
              )),
        ),
        Column(
          children: getPayments(context),
        )
      ],
    );
  }

  Widget CustomTile(
      BuildContext context, IconData icon, String text, num? value,
      {String? stringValue, bool? advancedValue, Color? backGround}) {
    bool currency = S.current.countOrdersDelivered != text;
    return Visibility(
      visible: value != null || stringValue != null,
      child: ScalingWidget(
        milliseconds: 1250,
        fade: true,
        child: ListTile(
          horizontalTitleGap: 0,
          leading: Icon(icon),
          title: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
          trailing: Container(
            constraints: const BoxConstraints(
                maxWidth: 120, minWidth: 95, maxHeight: 55),
            decoration: BoxDecoration(
              color: advancedValue != null
                  ? (advancedValue ? Colors.green : Colors.red)
                  : (backGround ?? Theme.of(context).disabledColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                stringValue ??
                    '${FixedNumber.getFixedNumber(value ?? 0)} ${currency ? S.current.sar : S.current.sOrder}',
                style: const TextStyle(
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget balanceDetails(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        CustomTile(context, Icons.account_balance_rounded, S.current.profit,
            model.amount),
        CustomTile(context, FontAwesomeIcons.store, S.current.amountForStore,
            model.amountForStore),
        CustomTile(
            context, FontAwesomeIcons.store, S.current.financeStoreStatus, null,
            stringValue: FinanceHelper.getStatusString(
                model.statusAmountForStore.toInt()),
            backGround: FinanceHelper.getFinanceStatusColor(
                model.statusAmountForStore.toInt())),
        CustomTile(
            context,
            FontAwesomeIcons.coins,
            S.current.sumCaptainFinancialDues,
            model.total.sumCaptainFinancialDues),
        CustomTile(
            context,
            Icons.payments,
            S.current.sumPaymentsToCaptainFinance,
            model.total.sumPaymentsToCaptain),
        CustomTile(
            context, FontAwesomeIcons.circle, S.current.financeStatus, null,
            stringValue: FinanceHelper.getStatusString(model.status.toInt()),
            backGround:
                FinanceHelper.getFinanceStatusColor(model.status.toInt())),
        const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16),
          child: Divider(
            thickness: 2,
          ),
        ),
        CustomTile(context, FontAwesomeIcons.creditCard, S.current.total,
            model.total.total,
            advancedValue: model.total.advancePayment),
      ],
    );
  }

  List<Widget> getPayments(context) {
    List<Widget> widgets = [];
    model.paymentsFromCompany.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Theme.of(context).backgroundColor,
            ),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              onTap: element.note != null
                  ? () {
                      showDialog(
                          context: context,
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
              subtitle: Text(FixedNumber.getFixedNumber(element.amount) +
                  ' ${S.current.sar}'),
              trailing: SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Text(DateFormat('yyyy/M/dd').format(element.paymentDate)),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: screenState.context,
                              builder: (context) {
                                return CustomAlertDialog(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      screenState.manager.deletePayment(
                                          screenState, element.id.toString());
                                    },
                                    oneAction: false,
                                    content: S
                                        .current.areYouSureToDeleteThisPayment);
                              });
                        },
                        icon: Icon(Icons.delete))
                  ],
                ),
              ),
            )),
      ));
    });
    if (widgets.isNotEmpty) {
      widgets.insert(
        0,
        const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16),
          child: Divider(
            thickness: 2,
          ),
        ),
      );
      widgets.insert(
        1,
        Text(
          S.current.captainPayments,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
    return widgets;
  }
}
