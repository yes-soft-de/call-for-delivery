import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/model/store_balance_model.dart';
import 'package:c4d/module_payments/ui/screen/store_balance_screen.dart';
import 'package:flutter/material.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/effect/hidder.dart';
import 'package:intl/intl.dart' as intl;

class StoreBalanceLoadedState extends States {
  StoreBalanceLoadedState(this.screenState, this.model,
      {this.error, this.empty = false})
      : super(screenState);

  final bool empty;
  final String? error;
  final StoreBalanceModel? model;
  final StoreBalanceScreenState screenState;
  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getPayments();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getPayments();
          });
    }
    return FixedContainer(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Hider(
          active: model?.paymentsToStore.isNotEmpty == true,
          child: ListView.builder(
            itemCount: model?.paymentsToStore.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (model != null) {
                var element = model!.paymentsToStore[index];
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color:
                          Theme.of(screenState.context).colorScheme.background,
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onTap: element.note != null
                          ? () {
                              showDialog(
                                  context: screenState.context,
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
                      leading: Icon(Icons.credit_card_rounded),
                      title: Text(S.current.paymentAmount),
                      subtitle: Text(element.amount.toString()),
                      trailing: SizedBox(
                        width: 130,
                        child: Row(
                          children: [
                            Text(intl.DateFormat('yyyy/M/dd')
                                .format(element.paymentDate)),
                            SizedBox(
                              width: 16,
                            ),
                            IconButton(
                                splashRadius: 15,
                                onPressed: () {
                                  showDialog(
                                      context: screenState.context,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                            oneAction: false,
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              screenState.deletePay(
                                                  element.id.toString());
                                            },
                                            content: S.current
                                                .areYouSureToDeleteThisPayment);
                                      });
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
