import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/request/update_distance_request.dart';
import 'package:c4d/module_orders/state_manager/orders_without_distance_state_manager.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:intl/intl.dart';

@injectable
class OrdersWithoutDistanceScreen extends StatefulWidget {
  final OrderWithoutDistanceStateManager _stateManager;

  OrdersWithoutDistanceScreen(this._stateManager);

  @override
  OrdersWithoutDistanceScreenState createState() =>
      OrdersWithoutDistanceScreenState();
}

class OrdersWithoutDistanceScreenState
    extends State<OrdersWithoutDistanceScreen> {
  late States currentState;
  int currentIndex = 0;
  StreamSubscription? _stateSubscription;
  OrderWithoutDistanceStateManager get manager => widget._stateManager;
  void updateDistance(UpdateDistanceRequest request) {
    widget._stateManager.updateDistance(this, request);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  void goToLogin() {
    Navigator.of(context)
        .pushNamed(AuthorizationRoutes.LOGIN_SCREEN, arguments: 1);
  }

  var today = DateTime.now();
  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    ordersFilter = FilterOrderRequest(
        fromDate: DateTime(today.year, today.month, today.day, 0),
        toDate: DateTime.now());
    widget._stateManager.getOrdersWithoutDistance(this, ordersFilter);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

  late FilterOrderRequest ordersFilter;
  Future<void> getOrders([bool loading = true]) async {
    widget._stateManager.getOrdersWithoutDistance(this, ordersFilter, loading);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.orderWithoutDistance, icon: Icons.menu, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }, actions: [
          CustomC4dAppBar.actionIcon(context, onTap: () {
            ordersFilter.fromDate =
                DateTime(today.year, today.month, today.day, 0);
            ordersFilter.toDate = DateTime.now();
            getOrders();
          }, icon: Icons.restart_alt_rounded)
        ]),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            // filter date
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    builder: (context, widget) {
                                      bool isDark =
                                          getIt<ThemePreferencesHelper>()
                                              .isDarkMode();

                                      if (isDark == false)
                                        return widget ?? SizedBox();
                                      return Theme(
                                          data: ThemeData.dark().copyWith(
                                              primaryColor: Colors.indigo),
                                          child: widget ?? SizedBox());
                                    },
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime.now())
                                .then((value) {
                              if (value != null) {
                                ordersFilter.fromDate = value;
                                setState(() {});
                                getOrders();
                              }
                            });
                          },
                          title: Text(S.current.firstDate),
                          subtitle: Text(ordersFilter.fromDate != null
                              ? DateFormat('yyyy/M/d').format(
                                  ordersFilter.fromDate ?? DateTime.now())
                              : '0000/00/00'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 2.5,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    builder: (context, widget) {
                                      bool isDark =
                                          getIt<ThemePreferencesHelper>()
                                              .isDarkMode();
                                      if (isDark == false)
                                        return widget ?? SizedBox();
                                      return Theme(
                                          data: ThemeData.dark().copyWith(
                                              primaryColor: Colors.indigo),
                                          child: widget ?? SizedBox());
                                    },
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime.now())
                                .then((value) {
                              if (value != null) {
                                ordersFilter.toDate = value;
                                setState(() {});
                                getOrders();
                              }
                            });
                          },
                          title: Text(S.current.endDate),
                          subtitle: Text(ordersFilter.toDate != null
                              ? DateFormat('yyyy/M/d')
                                  .format(ordersFilter.toDate ?? DateTime.now())
                              : '0000/00/00'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: currentState.getUI(context))
          ],
        ),
      ),
    );
  }
}
