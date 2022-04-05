import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/global_nav_key.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_stores/request/captain_not_arrived_request.dart';
import 'package:c4d/module_stores/state_manager/order/order_captain_not_arrived_state_manager.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class OrderCaptainNotArrivedScreen extends StatefulWidget {
  final OrderCaptainNotArrivedStateManager _stateManager;

  OrderCaptainNotArrivedScreen(this._stateManager);

  @override
  OrderCaptainNotArrivedScreenState createState() => OrderCaptainNotArrivedScreenState();
}

class OrderCaptainNotArrivedScreenState extends State<OrderCaptainNotArrivedScreen> {
  late States currentState;
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
  int? storeID = -1;
  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    widget._stateManager.getOrdersFilters(this, ordersFilter);
  }

  late FilterOrderCaptainNotArrivedRequest  ordersFilter=        ordersFilter = FilterOrderCaptainNotArrivedRequest(
      fromDate:
      DateTime(today.year, today.month, today.day, 0).toIso8601String(),
      toDate: DateTime.now().toIso8601String());

  Future<void> getOrders([bool loading = true]) async {
    widget._stateManager.getOrdersFilters(this, ordersFilter, loading);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
        title: S.current.orderLog,icon: Icons.menu, onTap: () {
            GlobalVariable.mainScreenScaffold.currentState?.openDrawer();
          }),
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
                              ordersFilter.fromDate = value.toIso8601String();
                              setState(() {});
                              getOrders();
                            }
                          });
                        },
                        title: Text(S.current.firstDate),
                        subtitle: Text(ordersFilter.fromDate != null
                            ? DateFormat('yyyy/M/d').format(DateTime.parse(
                            ordersFilter.fromDate ??
                                DateTime.now().toIso8601String()))
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
                              ordersFilter.toDate = value.toIso8601String();
                              setState(() {});
                              getOrders();
                            }
                          });
                        },
                        title: Text(S.current.endDate),
                        subtitle: Text(ordersFilter.toDate != null
                            ? DateFormat('yyyy/M/d').format(DateTime.parse(
                            ordersFilter.toDate ??
                                DateTime.now().toIso8601String()))
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
          Expanded(child: currentState.getUI(context))
        ],
      ),
    );
  }
}