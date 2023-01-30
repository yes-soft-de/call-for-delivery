import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/flat_bar.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:c4d/module_orders/state_manager/order_logs_state_manager.dart';
import 'package:intl/intl.dart';

@injectable
class OrderLogsScreen extends StatefulWidget {
  final OrderLogsStateManager _stateManager;

  const OrderLogsScreen(this._stateManager);

  @override
  OrderLogsScreenState createState() => OrderLogsScreenState();
}

class OrderLogsScreenState extends State<OrderLogsScreen> {
  late States currentState;
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
  @override
  void initState() {
    super.initState();
    currentState = LoadingState(this);
    ordersFilter = FilterOrderRequest(
        state: 'ongoing',
        fromDate: DateTime(today.year, today.month, today.day, 0),
        toDate: DateTime.now());
    widget._stateManager.getOrdersFilters(this, ordersFilter);
    widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
  }

  late FilterOrderRequest ordersFilter;
  Future<void> getOrders([bool loading = true]) async {
    widget._stateManager.getOrdersFilters(this, ordersFilter, loading);
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
            title: S.current.orderLog,
            actions: [
              CustomC4dAppBar.actionIcon(context, onTap: () {
                ordersFilter.fromDate =
                    DateTime(today.year, today.month, today.day, 0);
                ordersFilter.toDate = DateTime.now();
                currentIndex = 0;
                ordersFilter.state = 'ongoing';
                getOrders();
              }, icon: Icons.restart_alt_rounded)
            ]),
        body: Column(
          children: [
            const SizedBox(
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

                                      if (isDark == false) {
                                        return widget ?? const SizedBox();
                                      }
                                      return Theme(
                                          data: ThemeData.dark().copyWith(
                                              primaryColor: Colors.indigo),
                                          child: widget ?? const SizedBox());
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
                                      if (isDark == false) {
                                        return widget ?? const SizedBox();
                                      }
                                      return Theme(
                                          data: ThemeData.dark().copyWith(
                                              primaryColor: Colors.indigo),
                                          child: widget ?? const SizedBox());
                                    },
                                    firstDate: DateTime(2021),
                                    lastDate: DateTime.now())
                                .then((value) {
                              if (value != null) {
                                var currentTime = TimeOfDay.now();
                                ordersFilter.toDate = DateTime(
                                    value.year,
                                    value.month,
                                    value.day,
                                    currentTime.hour,
                                    currentTime.minute);
                                setState(() {});
                                getOrders();
                              }
                            });
                          },
                          title: Text(S.current.endDate),
                          subtitle: Text(ordersFilter.toDate != null
                              ? DateFormat('yyyy/M/d').format(
                                  ordersFilter.toDate ??
                                      DateTime.now())
                              : '0000/00/00'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            // filter on state
            FilterBar(
              cursorRadius: BorderRadius.circular(25),
              animationDuration: const Duration(milliseconds: 350),
              backgroundColor: Theme.of(context).backgroundColor,
              currentIndex: currentIndex,
              borderRadius: BorderRadius.circular(25),
              floating: true,
              height: 40,
              cursorColor: StatusHelper.getOrderStatusColor(
                  StatusHelper.getStatusEnum(ordersFilter.state)),
              items: [
                FilterItem(label: S.current.ongoing),
                FilterItem(label: S.current.completed),
                FilterItem(label: S.current.cancelled2),
              ],
              onItemSelected: (index) {
                if (index == 0) {
                  ordersFilter.state = 'ongoing';
                } else if (index == 2) {
                  ordersFilter.state = 'cancelled';
                } else {
                  ordersFilter.state = 'delivered';
                }
                currentIndex = index;
                getOrders();
              },
              selectedContent: Theme.of(context).textTheme.button!.color!,
              unselectedContent: Theme.of(context).textTheme.headline6!.color!,
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(child: currentState.getUI(context))
          ],
        ),
      ),
    );
  }
}
