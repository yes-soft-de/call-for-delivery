import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_my_notifications/my_notifications_routes.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_statistics/state_manager/statistics_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StatisticsScreen extends StatefulWidget {
  final StatisticsStateManager _stateManager;

  const StatisticsScreen(this._stateManager);

  @override
  State<StatisticsScreen> createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  late States state;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    state = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      state = event;
      if (this.mounted) {
        setState(() {});
      }
    });
    getStatistics();
    super.initState();
  }

  void getStatistics() {
    widget._stateManager.getStatistics(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.menu, onTap: () {
        GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
      }, actions: [
        CustomC4dAppBar.actionIcon(context, onTap: () {
          Navigator.of(context)
              .pushNamed(MyNotificationsRoutes.MY_NOTIFICATIONS);
        }, icon: Icons.notifications),
        CustomC4dAppBar.actionIcon(context, onTap: () {
          Navigator.of(context)
              .pushNamed(OrdersRoutes.SEARCH_FOR_ORDERS_SCREEN);
        }, icon: Icons.search)
      ]),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
                child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      ImageAsset.DELIVERY,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ))),
          ),
          state.getUI(context)
        ],
      ),
    );
  }
}
