import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/hive/util/argument_hive_helper.dart';
import 'package:c4d/module_orders/request/order_filter_request.dart';
import 'package:c4d/module_orders/state_manager/order_captain_logs_state_manager.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/module_orders/ui/widgets/label_text.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:intl/intl.dart';

@injectable
class OrderCaptainLogsScreen extends StatefulWidget {
  final OrderCaptainLogsStateManager _stateManager;

  OrderCaptainLogsScreen(this._stateManager);

  @override
  OrderCaptainLogsScreenState createState() => OrderCaptainLogsScreenState();
}

class OrderCaptainLogsScreenState extends State<OrderCaptainLogsScreen> {
  late States currentState;
  int currentIndex = 0;
  StreamSubscription? _stateSubscription;

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
        captainID: ArgumentHiveHelper().getCurrentCaptainID(),
        fromDate:
            DateTime(today.year, today.month, today.day, 0).toIso8601String(),
        toDate: DateTime.now().toIso8601String());
    widget._stateManager.getOrdersFilters(this, ordersFilter);
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
    ordersFilter.payment = payment;
    widget._stateManager.getOrdersFilters(this, ordersFilter, loading);
  }

  String? payment;
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
                showDialog(
                    context: context,
                    builder: (ctx) {
                      String? paymentType = payment;
                      return StatefulBuilder(builder: (_, refresh) {
                        return AlertDialog(
                          title: Text(S.current.filter),
                          content: Column(
                            children: [
                              ListTile(
                                title: LabelText(S.of(context).paymentMethod),
                                subtitle: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Theme.of(context).backgroundColor),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, right: 16),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          value: paymentType,
                                          items: getPaymentsMethod(),
                                          hint: Text(S.current.paymentMethod),
                                          onChanged: (String? value) {
                                            paymentType = value;
                                            refresh(() {});
                                            setState(() {});
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          scrollable: true,
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(S.current.cancel)),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  payment = paymentType;
                                  getOrders();
                                },
                                child: Text(S.current.confirm)),
                          ],
                        );
                      });
                    });
              }, icon: FontAwesomeIcons.filter),
              CustomC4dAppBar.actionIcon(context, onTap: () {
                ordersFilter.fromDate =
                    DateTime(today.year, today.month, today.day, 0)
                        .toIso8601String();
                ordersFilter.toDate = DateTime.now().toIso8601String();
                currentIndex = 0;
                ordersFilter.state = 'ongoing';
                getOrders();
              }, icon: Icons.restart_alt_rounded),
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
            // filter on state
            FilterBar(
              cursorRadius: BorderRadius.circular(25),
              animationDuration: Duration(milliseconds: 350),
              backgroundColor: Theme.of(context).backgroundColor,
              currentIndex: currentIndex,
              borderRadius: BorderRadius.circular(25),
              floating: true,
              height: 40,
              cursorColor: Theme.of(context).colorScheme.primary,
              items: [
                FilterItem(label: S.current.ongoing),
                FilterItem(label: S.current.completed),
              ],
              onItemSelected: (index) {
                if (index == 0) {
                  ordersFilter.state = 'ongoing';
                } else if (index == 1) {
                  ordersFilter.state = 'delivered';
                }
                currentIndex = index;
                getOrders();
              },
              selectedContent: Theme.of(context).textTheme.button!.color!,
              unselectedContent: Theme.of(context).textTheme.headline6!.color!,
            ),
            Visibility(
                visible: payment != null,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    FilterChip(
                      showCheckmark: true,
                      checkmarkColor: Colors.white,
                      label: Text(
                        payment ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: true,
                      labelStyle: TextStyle(color: Colors.white),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      onSelected: (bool value) {},
                    )
                  ]),
                )),
            Expanded(child: currentState.getUI(context))
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getPaymentsMethod() {
    var payment = [S.current.all, S.current.card, S.current.cash];
    List<DropdownMenuItem<String>> menu = [];
    payment.forEach((element) {
      menu.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return menu;
  }
}
