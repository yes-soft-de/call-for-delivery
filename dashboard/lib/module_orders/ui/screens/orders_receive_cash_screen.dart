import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/state_manager/orders_recieve_cash_state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:intl/intl.dart';

class OrdersReceiveCashScreen extends StatefulWidget {
  OrdersReceiveCashScreen();

  @override
  OrdersReceiveCashScreenState createState() => OrdersReceiveCashScreenState();
}

class OrdersReceiveCashScreenState extends State<OrdersReceiveCashScreen> {
  late States currentState;
  late OrdersReceiveCashStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  int currentIndex = 0;

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
  OrdersReceiveCashStateManager get manager => _stateManager;
  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    _stateManager = getIt();
    ordersFilter = FilterOrderRequest();
    _stateManager.getOrdersFilters(this, ordersFilter);
    _stateSubscription = _stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  late FilterOrderRequest ordersFilter;
  Future<void> getOrders([bool loading = true]) async {
    _stateManager.getOrdersFilters(this, ordersFilter, loading);
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
            title: S.current.orderLog, icon: Icons.menu, onTap: () {
          GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
        }, actions: [
          CustomC4dAppBar.actionIcon(context, onTap: () {
            ordersFilter.fromDate = null;
            ordersFilter.toDate = null;
            currentIndex = 0;
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
                        color: Theme.of(context).colorScheme.background,
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
                      color: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).colorScheme.background,
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
            SizedBox(
              height: 8,
            ),
            // filter on state
            FilterBar(
              cursorRadius: BorderRadius.circular(25),
              animationDuration: Duration(milliseconds: 350),
              backgroundColor: Theme.of(context).colorScheme.background,
              currentIndex: currentIndex,
              borderRadius: BorderRadius.circular(25),
              floating: true,
              height: 40,
              cursorColor: Theme.of(context).colorScheme.primary,
              items: [
                FilterItem(
                  label: S.current.ordersCashNotAnswered,
                ),
                FilterItem(label: S.current.ordersCashConflictsAnswer),
              ],
              onItemSelected: (index) {
                currentIndex = index;
                getOrders();
              },
              selectedContent: Theme.of(context).textTheme.labelLarge!.color!,
              unselectedContent: Theme.of(context).textTheme.titleLarge!.color!,
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(child: currentState.getUI(context))
          ],
        ),
      ),
    );
  }
}
