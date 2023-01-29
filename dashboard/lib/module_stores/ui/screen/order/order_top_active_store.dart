import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_stores/request/order_filter_request.dart';
import 'package:c4d/module_stores/state_manager/order/filter_orders_top_active_state_manager.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:intl/intl.dart';

@injectable
class OrdersTopActiveStoreScreen extends StatefulWidget {
  final FilterOrderTopStateManager _stateManager;

  OrdersTopActiveStoreScreen(this._stateManager);

  @override
  OrdersTopActiveStoreScreenState createState() =>
      OrdersTopActiveStoreScreenState();
}

class OrdersTopActiveStoreScreenState
    extends State<OrdersTopActiveStoreScreen> {
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
  String? storeName = '';
  TextEditingController geoController = TextEditingController();
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
  }

  late FilterOrderRequest ordersFilter;
  Future<void> getOrders([bool loading = true]) async {
    widget._stateManager.getOrdersFilters(this, ordersFilter, loading);
  }

  @override
  Widget build(BuildContext context) {
    if (storeID == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is List) {
        storeID = arg[2];
        storeName = arg[3];
        ordersFilter = FilterOrderRequest(
            fromDate: arg[0], toDate: arg[1], storeOwnerProfileId: storeID);
        widget._stateManager.getOrdersFilters(this, ordersFilter);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.storeOrderLog + ' ' + (storeName ?? ''),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          // filter date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                            ? DateFormat('yyyy/M/d')
                                .format(ordersFilter.fromDate ?? DateTime.now())
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
                              ordersFilter.toDate = DateTime(
                                value.year,
                                value.month,
                                value.day,
                              );
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

          SizedBox(
            height: 16,
          ),
          Expanded(child: currentState.getUI(context))
        ],
      ),
    );
  }

  void changeDistanceIndicator() {
    ordersFilter.maxKiloFromDistance = num.tryParse(geoController.text) ?? -1;
    ordersFilter.maxKilo = num.tryParse(geoController.text) ?? -1;
    // ordersFilter.chosenDistanceIndicator = geoKilo ? 2 : 1;
  }
}
