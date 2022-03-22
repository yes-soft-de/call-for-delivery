import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/error_screen.dart';

import 'captain_orders_list_state.dart';

class CaptainOrdersListStateError extends CaptainOrdersListState {
  final List<String> errors;

  CaptainOrdersListStateError(this.errors, CaptainOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    List<String> errs = LinkedHashSet<String>.from(errors).toList();
    if (errs.length > 1) {
      return Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.of(context).home, icon: Icons.sort_rounded, onTap: () {
          screenState.advancedController.showDrawer();
        }, buttonBackground: Colors.red),
        body: ErrorStateWidget(
          onRefresh: () {
            screenState.getMyOrders();
          },
          errors: errs,
        ),
      );
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.sort_rounded, onTap: () {
        screenState.advancedController.showDrawer();
      }, colorIcon: Theme.of(context).colorScheme.error),
      body: ErrorStateWidget(
        onRefresh: () {
          screenState.getMyOrders();
        },
        error: errs.first,
      ),
    );
  }
}
