import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_subscription/model/store_subscriptions_financial.dart';
import 'package:c4d/module_subscription/subscriptions_routes.dart';
import 'package:c4d/module_subscription/ui/screens/store_subscriptions_screen.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/subscription_status_helper.dart';
import 'package:flutter/material.dart';

class StoreSubscriptionsFinanceStateLoaded extends States {
  List<StoreSubscriptionsFinanceModel>? dues;
  final StoreSubscriptionsFinanceScreenState screenState;
  StoreSubscriptionsFinanceStateLoaded(this.screenState, this.dues)
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getDues());
  }

  List<Widget> getDues() {
    var context = screenState.context;
    List<Widget> widgets = [];
    widgets.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.primary),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            S.current.balanceHint,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    ));
    dues?.forEach((element) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.of(context).pushNamed(
                  SubscriptionsRoutes.SUBSCRIPTIONS_DUES_DETAILS_SCREEN,
                  arguments: element);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 0.5,
                        offset: const Offset(-1, 0),
                        color: Theme.of(context).colorScheme.background),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // financial cycleDate
                    Center(
                        child: Text(
                      element.packageName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: verticalBubble(
                                  subtitle: element.startDate,
                                  title: S.current.subscriptionDate)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 32,
                              height: 2.5,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Expanded(
                              child: verticalBubble(
                                  title: S.current.expirationData,
                                  subtitle: element.endDate)),
                        ],
                      ),
                    ),
                    // financial summery
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: verticalBubble(
                                  title: S.current.requiredToPay,
                                  subtitle: FixedNumber.getFixedNumber(
                                          element.total.requiredToPay) +
                                      ' ${S.current.sar}')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 32,
                              height: 2.5,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Expanded(
                              child: verticalBubble(
                                  title: S.current.sumPayments,
                                  subtitle: FixedNumber.getFixedNumber(
                                          element.total.sumPayments) +
                                      ' ${S.current.sar}')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: verticalBubble(
                                title: S.current.leftToPay,
                                subtitle: FixedNumber.getFixedNumber(
                                        element.total.total) +
                                    ' ${S.current.sar}',
                                background: element.total.advancePayment == 166
                                    ? null
                                    : (element.total.advancePayment == 167
                                        ? Colors.green
                                        : element.total.advancePayment == 168
                                        : element.total.advancePayment == 166
                                            ? Colors.red
                                            : Theme.of(screenState.context)
                                                .disabledColor)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 32,
                              height: 2.5,
                              color: Theme.of(context).colorScheme.background,
                            ),
                          ),
                          Expanded(
                              child: verticalBubble(
                            title: S.current.subscriptionStatus,
                            subtitle:
                                SubscriptionsStatusHelper.getStatusMessage(
                                    element.status),
                            background:
                                SubscriptionsStatusHelper.getStatusColor(
                                    element.status),
                            subtitleText: true,
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ));
    });

    return widgets;
  }

  Widget getVerticalTile(
      {required String title,
      required String subtitle,
      Color? backgroundColor}) {
    var context = screenState.context;
    return Column(
      children: [
        Text(title),
        Container(
            color: backgroundColor ?? Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                subtitle,
                style: TextStyle(
                    color: backgroundColor != null ? Colors.white : null),
              ),
            )),
      ],
    );
  }

  Widget verticalBubble(
      {required String title,
      required String subtitle,
      Color? background,
      bool subtitleText = false}) {
    var context = screenState.context;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: background ?? Theme.of(context).colorScheme.background,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          title: Text(title,
              style: TextStyle(
                  fontSize: 14,
                  color: background != null ? Colors.white : null)),
          subtitle: Text(subtitle,
              style: TextStyle(
                  color: background != null ? Colors.white : null,
                  fontSize: subtitleText ? 14 : null)),
        ),
      ),
    );
  }
}
