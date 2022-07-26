import 'dart:ui';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_stores/hive/store_hive_helper.dart';
import 'package:c4d/module_stores/model/store_subscriptions_financial.dart';
import 'package:c4d/module_stores/ui/screen/store_subscriptions_details_screen.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/date_converter.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/subscription_status_helper.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StoreSubscriptionsFinanceDetailsStateLoaded extends States {
  final StoreSubscriptionsFinanceDetailsScreenState screenState;
  StoreSubscriptionsFinanceDetailsStateLoaded(this.screenState)
      : super(screenState);
  late StoreSubscriptionsFinanceModel model;
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
                    title: Text(S.current.subscriptionsFinanceDetailsHint +
                        ' ${model.startDate + ' - ' + model.endDate}'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0, left: 16),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.8),
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.9),
                            Theme.of(context).colorScheme.primary,
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: getDetails(),
                      ),
                    ),
                  ),
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
                          title: Text(S.current.paymentFromStore),
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
                                            CreateStorePaymentsRequest(
                                              flag: (num.tryParse(_amount.text
                                                              .trim()) ??
                                                          0) >=
                                                      ((model.total
                                                                  .packageCost +
                                                              model.total
                                                                  .captainOffer) -
                                                          model.total
                                                              .sumPayments)
                                                  ? 1
                                                  : 3,
                                              subscriptionId: model.id,
                                              storeId: StoresHiveHelper()
                                                  .getCurrentStoreID(),
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
          children: getPayments(),
        )
      ],
    );
  }

  Widget CustomTile(IconData icon, String text, num? value,
      {String? stringValue, bool? advancedValue, Color? backGround}) {
    bool currency = S.current.countOrdersDelivered != text;
    var context = screenState.context;
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

  List<Widget> getPayments() {
    var context = screenState.context;
    List<Widget> widgets = [];
    model.paymentsFromStore.forEach((element) {
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
          S.current.storePayments,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
    return widgets;
  }

  Widget getDetails() {
    var context = screenState.context;
    return Column(
      children: [
        Text(
          model.packageName,
          style: TextStyle(
              color: Theme.of(context).textTheme.button?.color,
              fontWeight: FontWeight.bold),
        ),
        Padding(
          padding:
              const EdgeInsets.only(right: 16.0, left: 16, top: 16, bottom: 16),
          child: DottedLine(
            dashColor: Theme.of(context).backgroundColor,
            lineThickness: 2.5,
            dashRadius: 25,
          ),
        ),
        RowBubble(
            firstBubble: verticalBubble(
                subtitle: model.startDate, title: S.current.subscriptionDate),
            secondBubble: verticalBubble(
                subtitle: model.endDate, title: S.current.expirationData)),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.subscriptionStatus),
            secondBubble: verticalBubble(
                title: SubscriptionsStatusHelper.getStatusMessage(model.status),
                background:
                    SubscriptionsStatusHelper.getStatusColor(model.status))),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.isFutureSubscriptions),
            secondBubble: verticalBubble(
                title: model.isFuture ? S.current.yes : S.current.no,
                background: model.isFuture ? Colors.green : Colors.grey)),

        // subscription details
        Divider(
          thickness: 2.5,
          color: Theme.of(context).backgroundColor,
          indent: 32,
          endIndent: 32,
        ),
        // here is the details
        RowBubble(
            firstBubble: verticalBubble(title: S.current.packageOrderCount),
            secondBubble: verticalBubble(title: '${model.packageOrderCount}')),
        RowBubble(
            firstBubble:
                verticalBubble(title: S.current.packageOrderRemainingOrders),
            secondBubble:
                verticalBubble(title: model.remainingOrders.toString())),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.packageCaptainsCount),
            secondBubble: verticalBubble(title: '${model.packageCarCount}')),
        RowBubble(
            firstBubble:
                verticalBubble(title: S.current.packageRemainingCaptains),
            secondBubble:
                verticalBubble(title: model.remainingCars.toString())),
        //
        Divider(
          thickness: 2.5,
          color: Theme.of(context).backgroundColor,
          indent: 32,
          endIndent: 32,
        ),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.packageCost),
            secondBubble: verticalBubble(
                title: FixedNumber.getFixedNumber(model.total.packageCost)
                        .toString() +
                    ' ${S.current.sar}')),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.captainsOffer),
            secondBubble: verticalBubble(
                title: FixedNumber.getFixedNumber(model.total.captainOffer)
                        .toString() +
                    ' ${S.current.sar}')),
        Visibility(
          visible: model.captainsOffer.isNotEmpty,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(), primary: Colors.amber),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(S.current.captainOffers),
                        scrollable: true,
                        content: Container(
                          child: Column(
                            children: getCaptainOffers(model),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(S.current.cancel))
                        ],
                      );
                    });
              },
              child: Text(
                S.current.captainOffers,
                style: TextStyle(color: Colors.white),
              )),
        ),
        RowBubble(
            firstBubble: verticalBubble(title: S.current.sumPayments),
            secondBubble: verticalBubble(
                title:
                    model.total.sumPayments.toString() + ' ${S.current.sar}')),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            indent: 16,
            endIndent: 16,
            thickness: 2.5,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        Container(
          constraints: BoxConstraints(minWidth: 125, maxWidth: 150),
          child: verticalBubble(
              subtitle: model.total.total.toString() + ' ${S.current.sar}',
              title: S.current.total,
              background: model.total.advancePayment == false
                  ? Colors.green
                  : Colors.red),
        )
      ],
    );
  }

  Widget RowBubble(
      {required Widget firstBubble, required Widget secondBubble}) {
    var context = screenState.context;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(child: firstBubble),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 32,
              height: 2.5,
              color: Theme.of(context).backgroundColor,
            ),
          ),
          Expanded(child: secondBubble),
        ],
      ),
    );
  }

  List<Widget> getCaptainOffers(StoreSubscriptionsFinanceModel model) {
    var context = screenState.context;
    List<Widget> widgets = [];
    model.captainsOffer.forEach((element) {
      var date = DateFormat.yMEd()
              .format(DateHelper.convert(element.startDate?.timestamp)) +
          ' ' +
          DateFormat.jm()
              .format(DateHelper.convert(element.startDate?.timestamp));
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          tileColor: Theme.of(context).backgroundColor,
          title: Text(FixedNumber.getFixedNumber(element.price ?? 0) +
              ' ${S.current.sar}'),
          subtitle: Text(date),
        ),
      ));
    });
    return widgets;
  }

  Widget verticalBubble(
      {required String title,
      String? subtitle,
      Color? background,
      bool subtitleText = false}) {
    var context = screenState.context;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: background ?? Theme.of(context).backgroundColor,
      ),
      child: Visibility(
        visible: subtitle != null,
        replacement: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: background != null ? Colors.white : null)),
        ),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title,
              style: TextStyle(
                  fontSize: 14,
                  color: background != null ? Colors.white : null)),
          subtitle: Text(subtitle ?? '',
              style: TextStyle(
                  color: background != null ? Colors.white : null,
                  fontSize: subtitleText ? 14 : null)),
        ),
      ),
    );
  }
}
