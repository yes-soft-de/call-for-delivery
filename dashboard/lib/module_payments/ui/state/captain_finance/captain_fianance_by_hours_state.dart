import 'package:flutter/material.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/captain_finance_by_hours_model.dart';
import 'package:c4d/module_payments/ui/screen/captain_finance_by_hours_screen.dart';
import 'package:c4d/module_payments/ui/widget/finance_by_hours_form.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/global/screen_type.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';

class CaptainFinanceByHoursLoadedState extends States {
  CaptainFinanceByHoursLoadedState(this.screenState, this.model,
      {this.error, this.empty = false})
      : super(screenState);

  final bool empty;
  final String? error;
  final List<CaptainFinanceByHoursModel>? model;
  final CaptainFinanceByHoursScreenState screenState;
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
      child: ListView.builder(
        itemCount: model?.length ?? 0,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (model != null) {
            var element = model![index];
            return Padding(
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
                              color: Theme.of(context).colorScheme.background,
                              offset: Offset(-1, 0),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              horizontalsTile(
                                  context,
                                  S.current.countHours,
                                  FixedNumber.getFixedNumber(
                                      element.countHours)),
                              horizontalsTile(
                                  context,
                                  S.current.salary,
                                  FixedNumber.getFixedNumber(element.salary) +
                                      ' ${S.current.sar}'),
                              horizontalsTile(
                                  context,
                                  S.current.compensationForEveryOrder,
                                  FixedNumber.getFixedNumber(
                                          element.compensationForEveryOrder) +
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    offset: Offset(-1, 0),
                                  )
                                ],
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return FinanceByHoursForm(
                                          request: element,
                                          onSave: (request) {
                                            request.id = element.id;
                                            screenState.stateManager
                                                .updateFinance(
                                                    screenState, request);
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
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
                                          content: S.current
                                              .areSureAboutDeleteThisFinance,
                                          oneAction: false,
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            screenState.stateManager
                                                .deleteFinance(
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
                    ),
                  ],
                ));
          }
          return SizedBox();
        },
      ),
    );
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
                  fontSize: ScreenType.isMobile(context) ? 13 : null),
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
                fontSize: ScreenType.isMobile(context) ? 12 : null),
          ),
        ],
      ),
    );
  }
}
