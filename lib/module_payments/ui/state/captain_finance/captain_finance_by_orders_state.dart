import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_finance_by_order_model.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_order_screen.dart';
import 'package:c4d/module_payments/ui/widget/finance_by_order_form.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/global/screen_type.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:intl/intl.dart' as intl;

class CaptainFinanceByOrderLoadedState extends States {
  CaptainFinanceByOrderLoadedState(this.screenState, this.model,
      {this.error, this.empty = false})
      : super(screenState);

  final bool empty;
  final String? error;
  final List<CaptainFinanceByOrderModel>? model;
  final CaptainFinanceByOrderScreenState screenState;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getFinances();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getFinances();
          });
    }
    return FixedContainer(
        child: CustomListView.custom(children: getFinancesWidgets(context)));
  }

  List<Widget> getFinancesWidgets(context) {
    List<Widget> widgets = [];
    model?.forEach((element) {
      widgets.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 1,
                        color: Theme.of(context).backgroundColor,
                        offset: Offset(-1, 0),
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      children: [
                        Text(
                          element.categoryName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0)
                              .copyWith(left: 16, right: 16),
                          child: DottedLine(
                            direction: Axis.horizontal,
                            dashColor: Theme.of(context).backgroundColor,
                            lineThickness: 2.5,
                            dashRadius: 25,
                          ),
                        ),
                        horizontalsTile(
                            context,
                            S.current.bounceCountOrdersInMonth,
                            FixedNumber.getFixedNumber(
                                    element.bounceCountOrdersInMonth) +
                                ' ' +
                                S.current.sOrder),
                        horizontalsTile(
                            context,
                            S.current.amount,
                            FixedNumber.getFixedNumber(element.amount) +
                                ' ${S.current.sar}'),
                        horizontalsTile(
                            context,
                            S.current.countKilometersFrom,
                            FixedNumber.getFixedNumber(
                                    element.countKilometersFrom) +
                                ' ${S.current.km}'),
                        horizontalsTile(
                            context,
                            S.current.countKilometersTo,
                            FixedNumber.getFixedNumber(
                                    element.countKilometersTo) +
                                ' ${S.current.km}'),
                        horizontalsTile(
                            context,
                            S.current.bounce,
                            FixedNumber.getFixedNumber(element.bounce) +
                                ' ${S.current.sar}'),
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 1,
                              color: Theme.of(context).backgroundColor,
                              offset: Offset(-1, 0),
                            )
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return FinanceByOrderForm(
                                    request: element,
                                    onSave: (request) {
                                      request.id = element.id;
                                      screenState.stateManager
                                          .updateFinance(screenState, request);
                                    },
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 1,
                              color: Theme.of(context).backgroundColor,
                              offset: Offset(-1, 0),
                            )
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomAlertDialog(
                                    content:
                                        S.current.areSureAboutDeleteThisFinance,
                                    oneAction: false,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      screenState.stateManager.deleteFinance(
                                          screenState, element.id);
                                    },
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )));
    });
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }

  Widget horizontalsTile(BuildContext context, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(16.0).copyWith(bottom: 8.0, top: 0),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenType.isMobile(context) ? 14 : null),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            subtitle,
            style: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
                fontSize: ScreenType.isMobile(context) ? 13 : null),
          ),
        ],
      ),
    );
  }
}
