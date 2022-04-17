import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/model/captain_balance_model.dart';
import 'package:c4d/module_captain/ui/screen/captain_account_balance_screen.dart';
import 'package:c4d/module_payments/payments_routes.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
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
    return Scaffold(
      appBar:
          CustomC4dAppBar.appBar(context, title: S.current.myBalance, actions: [
        CustomC4dAppBar.actionIcon(context, onTap: () {
          Navigator.of(context).pushNamed(PaymentsRoutes.PAYMENTS_TO_CAPTAIN,
              arguments: screenState.captainID);
        }, icon: Icons.account_balance_rounded),
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

  Widget balanceDetails(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [
        CustomTile(FontAwesomeIcons.boxes, S.current.countOrders, null,
            stringValue: balance?.countOrders.toString()),
        CustomTile(
            FontAwesomeIcons.road, S.current.countOrdersMaxFromNineteen, null,
            stringValue: balance?.countOrdersMaxFromNineteen.toString()),
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
