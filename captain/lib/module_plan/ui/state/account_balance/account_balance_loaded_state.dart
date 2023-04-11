import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_balance_model.dart';
import 'package:c4d/module_plan/ui/screen/account_balance_screen.dart';
import 'package:c4d/module_plan/ui/widget/account_balance_details.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/advanced_payment_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountBalanceStateLoaded extends States {
  CaptainAccountBalanceModel? balance;
  final AccountBalanceScreenState screenState;
  AccountBalanceStateLoaded(this.screenState, this.balance)
      : super(screenState) {
    try {
      _scrollController.addListener(() {
        first = false;
        screenState.refresh();
      });
    } catch (e) {
      //
    }
  }
  int currentIndex = 0;
  ScrollController _scrollController = ScrollController();
  bool first = true;
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.background,
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
                  Visibility(
                    visible: false,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return CustomAlertDialog(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      screenState.manager
                                          .stopeCurrentAccountPlan(screenState);
                                    },
                                    content:
                                        S.current.areSureAboutStoppingPlan);
                              });
                        },
                        child: Text(S.current.stopPlan)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget CustomTile(
    IconData icon,
    String text,
    num? value, {
    String? stringValue,
    int? advancePayment,
  }) {
    bool currency = S.current.countOrdersDelivered != text;
    return Visibility(
      visible: value != null || stringValue != null,
      child: ScalingWidget(
        milliseconds: 1250,
        fade: true,
        child: ListTile(
          horizontalTitleGap: 0,
          leading: Icon(icon),
          title: Text(text),
          trailing: Container(
            constraints: const BoxConstraints(
                maxWidth: 120, minWidth: 95, maxHeight: 55),
            decoration: BoxDecoration(
              color:
                  AdvancedPaymentHelper.getFinanceStatusColor(advancePayment),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                stringValue ??
                    '${FixedNumber.getFixedNumber(value ?? 0)} ${currency ? S.current.sar : S.current.sOrder}',
                style: const TextStyle(color: Colors.white, fontSize: 14),
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
      child: Stack(
        children: [
          SizedBox(
            height: 407,
            width: double.maxFinite,
            child: Scrollbar(
              radius: const Radius.circular(25),
              thumbVisibility: true,
              child: ListView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                scrollDirection: Axis.horizontal,
                children: data,
              ),
            ),
          ),
          Visibility(
            visible:
                maxOffset() && (balance?.orderCountsDetails?.length ?? -1) > 1,
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SizedBox(
                height: 407 - 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Opacity(
                    opacity: 0.4,
                    child: Icon(
                      Icons.arrow_forward,
                      color: maxOffset()
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible:
                minOffset() && (balance?.orderCountsDetails?.length ?? -1) > 1,
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                  height: 407 - 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Opacity(
                      opacity: 0.4,
                      child: Icon(
                        Icons.arrow_back,
                        color: minOffset()
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).disabledColor,
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget balanceDetails(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        countOrderDetails(context),
        CustomTile(FontAwesomeIcons.boxes, S.current.countOrders, null,
            stringValue: balance?.ordersInMonth?.toString()),
        CustomTile(FontAwesomeIcons.boxes, S.current.countOrdersCompleted, null,
            stringValue: balance?.countOrders?.toString()),
        CustomTile(
            FontAwesomeIcons.road, S.current.countOrdersMaxFromNineteen, null,
            stringValue: balance?.countOrdersMaxFromNineteen?.toString()),
        CustomTile(FontAwesomeIcons.road, S.current.compensationForEveryOrder,
            balance?.compensationForEveryOrder),
        CustomTile(
            FontAwesomeIcons.moneyBill, S.current.salary, balance?.salary),
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
        Visibility(
            visible: balance?.monthTargetSuccess != null,
            child: Column(
              children: [
                SizedBox(
                  width: 170,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: const Icon(FontAwesomeIcons.chartBar),
                    title: Text(S.current.monthTargetSuccess),
                  ),
                ),
                Flushbar(
                  icon: const Icon(
                    FontAwesomeIcons.chartPie,
                    color: Colors.white,
                  ),
                  message: balance?.monthTargetSuccess ?? '',
                  flushbarStyle: FlushbarStyle.FLOATING,
                  borderRadius: BorderRadius.circular(18),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            )),
        CustomTile(Icons.checklist_rounded, S.current.countOrdersCompleted,
            balance?.countOrdersCompleted),
        CustomTile(FontAwesomeIcons.store, S.current.amountForStore,
            balance?.amountForStore ?? 0),
        // CustomTile(
        //     FontAwesomeIcons.calendar, S.current.dateFinancialCycleEnds, null,
        //     stringValue: balance?.dateFinancialCycleEnds),
        const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16),
          child: Divider(
            thickness: 2,
          ),
        ),
        CustomTile(FontAwesomeIcons.creditCard, S.current.total, balance?.total,
            advancePayment: balance?.advancePayment),
      ],
    );
  }

  bool maxOffset() {
    if (first && (balance?.orderCountsDetails?.length ?? -1) > 1) {
      return true;
    }
    if (_scrollController.hasClients) {
      return _scrollController.position.maxScrollExtent >
          _scrollController.offset;
    } else {
      return false;
    }
  }

  bool minOffset() {
    if (_scrollController.hasClients) {
      return _scrollController.position.minScrollExtent <
          _scrollController.offset;
    } else {
      return false;
    }
  }
}
