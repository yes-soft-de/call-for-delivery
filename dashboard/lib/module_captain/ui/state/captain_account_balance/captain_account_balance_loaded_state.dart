import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_balance_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_account_balance_screen.dart';
import 'package:c4d/module_captain/ui/widget/account_balance_details.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountBalanceStateLoaded extends States {
  CaptainAccountBalanceModel? balance;
  final CaptainAccountBalanceScreenState screenState;
  AccountBalanceStateLoaded(this.screenState, this.balance)
      : super(screenState);
  int currentIndex = 0;
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
                    title: Text(S.current.BalanceHint),
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
    );
  }

  Widget CustomTile(
    IconData icon,
    String text,
    num? value, {
    String? stringValue,
    int? advancedValue,
  }) {
    bool currency = S.current.countOrdersDelivered != text;
    return Visibility(
      visible: value != null || stringValue != null,
      child: ScalingWidget(
        milliseconds: 1250,
        fade: true,
        child: ListTile(
          leading: Icon(icon),
          title: Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
          trailing: Container(
            constraints: const BoxConstraints(
                maxWidth: 120, minWidth: 95, maxHeight: 55),
            decoration: BoxDecoration(
              color: advancedValue == null
                  ? null
                  : (advancedValue == 160
                      ? Colors.green
                      : advancedValue == 159
                          ? Colors.red
                          : Theme.of(screenState.context).disabledColor),
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
        orders: e.orders,
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
        CustomTile(
            FontAwesomeIcons.chartBar, S.current.monthTargetSuccess, null,
            stringValue: balance?.monthTargetSuccess),
        CustomTile(Icons.checklist_rounded, S.current.countOrdersCompleted,
            balance?.countOrdersCompleted),
        Visibility(
            visible: balance?.orders.isNotEmpty == true,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return Scaffold(
                        appBar: CustomC4dAppBar.appBar(context,
                            title: S.current.order),
                        body: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                children:
                                    getOrders(context, balance?.orders ?? []),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(S.current.close))
                          ],
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  S.current.orders,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            )),
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
            advancedValue: balance?.advancePayment),
      ],
    );
  }

  List<Widget> getOrders(context, List<OrderModel> orders) {
    List<Widget> widgets = [];
    orders.forEach((element) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                    StoresRoutes.ORDER_STATUS_SCREEN,
                    arguments: element.id);
              },
              child: OwnerOrderCard(
                createdDate: element.createdDate,
                deliveryDate: element.deliveryDate,
                note: element.note,
                orderCost: element.orderCost,
                orderNumber: element.id.toString(),
                orderStatus: StatusHelper.getOrderStatusMessages(element.state),
                orderIsMain: element.orderIsMain,
              )),
        ),
      );
    });
    return widgets;
  }
}
