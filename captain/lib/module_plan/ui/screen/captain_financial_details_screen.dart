import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_plan/model/captain_financial_dues.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/finance_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class CaptainFinancialDuesDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      CaptainFinancialDuesDetailsScreenState();
}

class CaptainFinancialDuesDetailsScreenState
    extends State<CaptainFinancialDuesDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  late CaptainFinancialDuesModel model;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args is CaptainFinancialDuesModel) {
      model = args;
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.financialDuesDetails),
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
            Column(
              children: getPayments(),
            )
          ],
        ));
  }

  Widget CustomTile(IconData icon, String text, num? value,
      {String? stringValue, bool? advancedValue, Color? backGround}) {
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
        CustomTile(
            Icons.account_balance_rounded, S.current.netProfit, model.amount),
        CustomTile(FontAwesomeIcons.store, S.current.amountForStore,
            model.amountForStore),
        CustomTile(FontAwesomeIcons.store, S.current.financeStoreStatus, null,
            stringValue: FinanceHelper.getStatusString(
                model.statusAmountForStore.toInt()),
            backGround: FinanceHelper.getFinanceStatusColor(
                model.statusAmountForStore.toInt())),
        CustomTile(FontAwesomeIcons.coins, S.current.sumCaptainFinancialDues,
            model.total.sumCaptainFinancialDues),
        CustomTile(Icons.payments, S.current.sumPaymentsToCaptainFinance,
            model.total.sumPaymentsToCaptain),
        CustomTile(FontAwesomeIcons.circle, S.current.financeStatus, null,
            stringValue: FinanceHelper.getStatusString(model.status.toInt()),
            backGround:
                FinanceHelper.getFinanceStatusColor(model.status.toInt())),
        const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 16),
          child: Divider(
            thickness: 2,
          ),
        ),
        CustomTile(
            FontAwesomeIcons.creditCard, S.current.total, model.total.total,
            advancedValue: model.total.advancePayment),
      ],
    );
  }

  List<Widget> getPayments() {
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
                child:
                    Text(DateFormat('yyyy/M/dd').format(element.paymentDate)),
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
    }
    return widgets;
  }
}
