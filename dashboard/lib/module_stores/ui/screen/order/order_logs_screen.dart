import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/module_notice/ui/widget/filter_bar.dart';
import 'package:c4d/module_stores/model/store_profile_model.dart';
import 'package:c4d/module_stores/request/order_filter_request.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import '../../../state_manager/order/order_logs_state_manager.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:intl/intl.dart';

@injectable
class OrderLogsScreen extends StatefulWidget {
  final OrderLogsStateManager _stateManager;

  OrderLogsScreen(this._stateManager);

  @override
  OrderLogsScreenState createState() => OrderLogsScreenState();
}

class OrderLogsScreenState extends State<OrderLogsScreen> {
  late States currentState;
  int currentIndex = 0;
  bool geoKilo = false;
  bool isExternalFilterOn = false;
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

  StoreProfileModel? store;
  @override
  Widget build(BuildContext context) {
    if (storeID == -1) {
      var arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null && arg is StoreProfileModel) {
        store = arg;
        storeID = arg.id;
        ordersFilter = FilterOrderRequest(
            storeOwnerProfileId: storeID,
            state: 'pending',
            fromDate: DateTime(today.year, today.month, today.day, 0),
            toDate: DateTime.now());
        widget._stateManager.getOrdersFilters(this, ordersFilter);
      }
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: S.current.storeOrderLog + ' ' + (store?.storeOwnerName ?? ''),
          actions: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    Text(
                      S.current.onlyExternal,
                    ),
                    SizedBox(width: 5),
                    Switch(
                      activeTrackColor: Color(0xff60CF86),
                      value: isExternalFilterOn,
                      onChanged: (value) {
                        isExternalFilterOn = value;
                        ordersFilter.externalOrder = isExternalFilterOn;
                        getOrders();
                        // setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ),
          ]),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          // filter date
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            // date picker
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
                label: S.current.pending,
              ),
              FilterItem(label: S.current.ongoing),
              FilterItem(label: S.current.completed),
              FilterItem(label: S.current.cancelled2),
            ],
            onItemSelected: (index) {
              if (index != 2) clearDistanceFilter();
              if (index == 0) {
                ordersFilter.state = 'pending';
              } else if (index == 1) {
                ordersFilter.state = 'ongoing';
              } else if (index == 3) {
                ordersFilter.state = 'cancelled';
              } else {
                ordersFilter.state = 'delivered';
              }
              currentIndex = index;
              getOrders();
            },
            selectedContent: Theme.of(context).textTheme.labelLarge!.color!,
            unselectedContent: Theme.of(context).textTheme.titleLarge!.color!,
          ),
          // kilo filter
          Visibility(
            visible: currentIndex == 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: CustomFormField(
                    numbers: true,
                    hintText: S.current.distanceBetweenClientAndStoreBranch,
                    controller: geoController,
                    onChanged: () {
                      changeDistanceIndicator();
                      if (geoController.text.isEmpty) clearDistanceFilter();
                      getOrders();
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        minLeadingWidth: 0,
                        title: Text(
                          S.of(context).captainDistance,
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Radio(
                          value: false,
                          groupValue: geoKilo,
                          onChanged: (value) {
                            geoKilo = false;
                            changeDistanceIndicator();
                            if (geoController.text.isEmpty) {
                              clearDistanceFilter();
                            }
                            refresh();
                            getOrders();
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        minLeadingWidth: 0,
                        title: Text(
                          S.current.geoDistance,
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Radio(
                          value: true,
                          groupValue: geoKilo,
                          onChanged: (value) {
                            geoKilo = true;
                            changeDistanceIndicator();
                            if (geoController.text.isEmpty) {
                              clearDistanceFilter();
                            }
                            refresh();
                            getOrders();
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(child: currentState.getUI(context))
        ],
      ),
    );
  }

  void changeDistanceIndicator() {
    ordersFilter.maxKiloFromDistance = num.tryParse(geoController.text) ?? -1;
    ordersFilter.maxKilo = num.tryParse(geoController.text) ?? -1;
    ordersFilter.chosenDistanceIndicator = geoKilo ? 2 : 1;
  }

  void clearDistanceFilter() {
    ordersFilter.maxKiloFromDistance = null;
    ordersFilter.maxKilo = null;
    ordersFilter.chosenDistanceIndicator = null;
  }
}
