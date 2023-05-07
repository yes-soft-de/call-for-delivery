import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/request/store_owner_payment_request.dart';
import 'package:c4d/module_stores/model/stores_dues/store_dues_model.dart';
import 'package:c4d/module_stores/ui/screen/stores_dues/store_dues_screen.dart';
import 'package:c4d/module_stores/ui/widget/stores_dues/store_dues_monthly_card.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:c4d/utils/components/fixed_container.dart';
import 'package:c4d/utils/helpers/date_utilts.dart';
import 'package:flutter/material.dart';

class StoreDuesLoadedState extends States {
  final StoreDuesScreenState screenState;
  final String? error;
  final bool empty;

  final List<StoreDuesModel> model;

  StoreDuesLoadedState(this.screenState, this.model,
      {this.empty = false, this.error})
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    if (error != null) {
      return ErrorStateWidget(
        onRefresh: () {
          screenState.getStoresDues();
        },
        error: error,
      );
    } else if (empty) {
      return EmptyStateWidget(
          empty: S.current.emptyStaff,
          onRefresh: () {
            screenState.getStoresDues();
          });
    }
    return FixedContainer(
        child: ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        var monthDate = DateTime(
            int.tryParse(screenState.filter.year ?? '0') ?? 0,
            model[index].month,
            1);

        return StoreDuesMonthlyCard(
          model: model[index],
          onPay: (amount, note) {
            screenState.stateManager.makePayments(
                screenState,
                CreateStorePaymentsRequest(
                    storeId: model[index].storeOwnerProfileId,
                    amount: amount,
                    note: note,
                    fromDate: monthDate.toIso8601String(),
                    toDate: getLastDayOnMonth(monthDate).toIso8601String()));
          },
        );
      },
    ));
  }
}
