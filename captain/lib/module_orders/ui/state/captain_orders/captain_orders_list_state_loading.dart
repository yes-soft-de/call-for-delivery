import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/state/captain_orders/captain_orders_list_state.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';

class CaptainOrdersListStateLoading extends CaptainOrdersListState {
  CaptainOrdersListStateLoading(CaptainOrdersScreenState screenState)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.sort_rounded, onTap: () {
        screenState.advancedController.showDrawer();
      }),
      body: Center(
        child: Lottie.asset('assets/animations/loading.json'),
      ),
    );
  }
}
