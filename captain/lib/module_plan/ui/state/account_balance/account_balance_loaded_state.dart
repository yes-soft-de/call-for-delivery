import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/plan_routes.dart';
import 'package:c4d/module_plan/ui/screen/account_balance_screen.dart';
import 'package:c4d/module_plan/ui/widget/account_balance_details.dart';
import 'package:c4d/module_plan/ui/widget/custom_text_button.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountBalanceStateLoaded extends States {
  CaptainAccountBalanceModel? balance;
  final AccountBalanceScreenState screenState;
  AccountBalanceStateLoaded(this.screenState, this.balance)
      : super(screenState);
  int currentIndex = 0;
  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar:
          CustomC4dAppBar.appBar(context, title: S.current.myBalance, actions: [
        CustomC4dAppBar.actionIcon(context, onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // buttons
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              // renew new subscription
                              CustomTextButton(
                                label: S.current.renewNewPlan,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pushNamed(
                                      PlanRoutes.PLAN_ROUTE,
                                      arguments: S.current.renewNewPlan);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // close button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder()),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                S.current.close,
                                style: Theme.of(context).textTheme.button,
                              ),
                            )),
                      ),
                    )
                  ],
                );
              });
        }, icon: Icons.restart_alt_rounded)
      ]),
      body: CustomListView.custom(
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
                      leading: const Icon(Icons.info_rounded),
                      title: Text(S.current.myBalanceHint),
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
        ],
      ),
    );
  }

  Widget CustomTile(
    IconData icon,
    String text,
    num? value, {
    String? stringValue,
    bool? advancedValue,
  }) {
    bool currency = S.current.countOrdersDelivered != text;
    return Visibility(
      visible: value != null || stringValue != null,
      child: ScalingWidget(
        milliseconds: 1250,
        fade: true,
        child: ListTile(
          leading: Icon(icon),
          title: Text(text),
          trailing: Container(
            constraints: const BoxConstraints(
                maxWidth: 120, minWidth: 95, maxHeight: 55),
            decoration: BoxDecoration(
              color: advancedValue != null
                  ? (advancedValue ? Colors.green : Colors.red)
                  : Theme.of(screenState.context).disabledColor,
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

  Widget countOrderDetails(BuildContext context) {
    var data = <Widget>[];
    balance?.orderCountsDetails?.forEach((e) {
      data.add(AccountBalanceDetailsCard(
        active: false,
        amount: e.amount,
        bounce: e.bounce,
        bounceCountOrdersInMonth: e.bounceCountOrdersInMonth,
        categoryName: e.categoryName,
        captainTotalCategory: e.captainTotalCategory,
        contOrderCompleted: e.contOrderCompleted,
        countKilometersFrom: e.countKilometersFrom,
        countKilometersTo: e.countKilometersTo,
        countOfOrdersLeft: e.countOfOrdersLeft,
        message: e.message,
      ));
    });
    return Visibility(
      visible: balance?.orderCountsDetails != null,
      child: SizedBox(
        height: 408,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: data,
        ),
      ),
    );
  }

  Widget balanceDetails(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        countOrderDetails(context),
        CustomTile(FontAwesomeIcons.boxes, S.current.countOrders, null,
            stringValue: balance?.countOrders?.toString()),
        CustomTile(
            FontAwesomeIcons.road, S.current.countOrdersMaxFromNineteen, null,
            stringValue: balance?.countOrdersMaxFromNineteen?.toString()),
        CustomTile(FontAwesomeIcons.road, S.current.compensationForEveryOrder,
            balance?.compensationForEveryOrder),
        CustomTile(
            FontAwesomeIcons.moneyBill, S.current.total, balance?.salary),
        CustomTile(FontAwesomeIcons.coins, S.current.financialDues,
            balance?.financialDues),
        CustomTile(Icons.payments, S.current.sumPayments, balance?.sumPayments),
        CustomTile(Icons.discount_rounded, S.current.monthCompensation,
            balance?.monthCompensation),
        CustomTile(
            FontAwesomeIcons.boxOpen,
            S.current.countOverOrdersThanRequired,
            balance?.countOverOrdersThanRequired),
        CustomTile(Icons.show_chart_rounded, S.current.bounce, balance?.bounce),
        CustomTile(
            FontAwesomeIcons.chartBar, S.current.monthTargetSuccess, null,
            stringValue: balance?.monthTargetSuccess),
        CustomTile(Icons.checklist_rounded, S.current.countOrdersCompleted,
            balance?.countOrdersCompleted),
        CustomTile(
            FontAwesomeIcons.calendar, S.current.dateFinancialCycleEnds, null,
            stringValue: balance?.dateFinancialCycleEnds),
        const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16),
          child: Divider(
            thickness: 2,
          ),
        ),
        CustomTile(FontAwesomeIcons.creditCard, S.current.total, balance?.total,
            advancedValue: balance?.advancePayment),
      ],
    );
  }
}
