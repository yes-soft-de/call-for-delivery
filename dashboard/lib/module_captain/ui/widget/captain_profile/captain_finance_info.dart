// ignore_for_file: must_be_immutable

import 'package:another_flushbar/flushbar.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/captains_routes.dart';
import 'package:c4d/module_captain/model/porfile_model.dart';
import 'package:c4d/utils/effect/scaling.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CaptainFinanceInfo extends StatefulWidget {
  OrderCountsSystemDetails details;
  final Function(bool) requestStatus;
  final int captainID;
  CaptainFinanceInfo(
      {Key? key,
      required this.details,
      required this.requestStatus,
      required this.captainID})
      : super(key: key);

  @override
  State<CaptainFinanceInfo> createState() => _CaptainFinanceInfoState();
}

class _CaptainFinanceInfoState extends State<CaptainFinanceInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Flushbar(
                  icon: Icon(
                    FontAwesomeIcons.info,
                    color: Colors.white,
                  ),
                  mainButton: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (widget.details.id == null) {
                        widget.details.id = widget.captainID;
                        Navigator.of(context).pushNamed(
                            CaptainsRoutes.CAPTAIN_PLAN,
                            arguments: widget.details);
                      } else {
                        Navigator.of(context).pushNamed(
                            CaptainsRoutes.CAPTAIN_PLAN,
                            arguments: widget.details);
                      }
                    },
                    icon: Icon(Icons.change_circle_rounded),
                    color: Colors.white,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  message: widget.details.status == false
                      ? S.current.youCanChangeCaptainFinancialPlan
                      : S.current.youCanChooseCaptainPlan,
                ),
                CustomTile(
                    FontAwesomeIcons.calendar, S.current.createDate, null,
                    stringValue: widget.details.createDate),
                CustomTile(
                    FontAwesomeIcons.calendarCheck, S.current.updateDate, null,
                    stringValue: widget.details.createDate),
                CustomTile(FontAwesomeIcons.balanceScale,
                    S.current.captainFinance, null,
                    stringValue: getCaptainType(
                        widget.details.captainFinancialSystemType)),
                CustomTile(FontAwesomeIcons.circle, S.current.status, null,
                    stringValue: widget.details.status == true
                        ? S.current.activatedPlan
                        : S.current.inactivePlan,
                    advancedValue: widget.details.status == true),
                CustomTile(Icons.person, S.current.updatedBy, null,
                    stringValue: widget.details.updatedBy),
                CustomTile(Icons.timer, S.current.countHours,
                    widget.details.countHours),
                CustomTile(
                    FontAwesomeIcons.boxes, S.current.countOrdersInMonth, null,
                    stringValue: widget.details.countOrdersInMonth?.toString()),
                CustomTile(
                    Icons.card_giftcard_rounded,
                    S.current.monthCompensation,
                    widget.details.monthCompensation),
                CustomTile(
                    FontAwesomeIcons.boxes,
                    S.current.bounceMaxCountOrdersInMonth,
                    widget.details.bounceMaxCountOrdersInMonth),
                CustomTile(
                    FontAwesomeIcons.boxes,
                    S.current.bounceMinCountOrdersInMonth,
                    widget.details.bounceMinCountOrdersInMonth),
                CustomTile(
                    Icons.money_rounded,
                    S.current.compensationForEveryOrder,
                    widget.details.compensationForEveryOrder),
                CustomTile(
                    Icons.credit_card, S.current.salary, widget.details.salary),
              ],
            ),
          ),
        ),
        Container(
          height: 65,
          child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 0, top: 0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        widget.requestStatus(false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(S.current.refuse,
                            style: Theme.of(context).textTheme.button),
                      )),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        widget.requestStatus(true);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(S.current.accept,
                            style: Theme.of(context).textTheme.button),
                      )),
                ),
              ],
            ),
          ),
        )
      ],
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
        child: Row(
          children: [
            Container(
                color: Theme.of(context).backgroundColor,
                width: 75,
                height: 55,
                child: Center(
                    child: Icon(
                  icon,
                  color: Theme.of(context).disabledColor,
                ))),
            SizedBox(
              width: 4,
            ),
            Container(
                height: 55,
                width: 130,
                color: Theme.of(context).backgroundColor,
                child: Center(
                    child: Text(
                  text,
                  style: TextStyle(fontSize: 14),
                ))),
            SizedBox(
              width: 4,
            ),
            Expanded(
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: advancedValue != null
                      ? (advancedValue ? Colors.green : Colors.red)
                      : Theme.of(context).backgroundColor,
                ),
                child: Center(
                  child: Text(
                    stringValue ??
                        '${FixedNumber.getFixedNumber(value ?? 0)} ${currency ? S.current.sar : S.current.sOrder}',
                    style: TextStyle(
                      color: advancedValue != null ? Colors.white : null,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getCaptainType(int? captainFinancialSystemType) {
    if (captainFinancialSystemType == null) {
      return S.current.unknown;
    } else {
      if (captainFinancialSystemType == 1) return S.current.financeByHours;
      if (captainFinancialSystemType == 2) return S.current.financeByOrders;
      if (captainFinancialSystemType == 3) return S.current.financeCountOrder;
      return S.current.unknown;
    }
  }
}
