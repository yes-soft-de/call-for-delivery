import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/hive/util/argument_hive_helper.dart';
import 'package:c4d/module_orders/request/captain_cash_finance_request.dart';
import 'package:c4d/module_orders/state_manager/order_cash_captain_state_manager.dart';
import 'package:c4d/module_payments/request/captain_payments_request.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_auth/authorization_routes.dart';
import 'package:intl/intl.dart';

@injectable
class OrdersCashCaptainScreen extends StatefulWidget {
  final OrderCashCaptainStateManager _stateManager;

  OrdersCashCaptainScreen(this._stateManager);

  @override
  OrdersCashCaptainScreenState createState() => OrdersCashCaptainScreenState();
}

class OrdersCashCaptainScreenState extends State<OrdersCashCaptainScreen> {
  late States currentState;
  int currentIndex = 0;
  StreamSubscription? _stateSubscription;
  TextEditingController _amount = TextEditingController();
  TextEditingController _note = TextEditingController();

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
    ordersFilter = CaptainCashFinanceRequest(
        captainId: ArgumentHiveHelper().getCurrentCaptainID(),
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

  late CaptainCashFinanceRequest ordersFilter;
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
        floatingActionButton: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(shape: StadiumBorder()),
          label: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(S.current.makePayment),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Icon(Icons.add),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(builder: (context, setState) {
                    return AlertDialog(
                      scrollable: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      title: Text(S.current.paymentsToCaptain),
                      content: Container(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(S.current.paymentAmount),
                              subtitle: CustomFormField(
                                onChanged: () {
                                  setState(() {});
                                },
                                numbers: true,
                                controller: _amount,
                                hintText: '100',
                              ),
                            ),
                            ListTile(
                              title: Text(S.current.note),
                              subtitle: CustomFormField(
                                controller: _note,
                                hintText: S.current.note,
                                last: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        ElevatedButton(
                            onPressed: _amount.text.isEmpty
                                ? null
                                : () {
                                    Navigator.of(context).pop();
                                    widget._stateManager.payForStore(
                                        this,
                                        CaptainPaymentsRequest(
                                          captainId: int.tryParse(
                                              ArgumentHiveHelper()
                                                      .getCurrentCaptainID() ??
                                                  ''),
                                          amount: num.tryParse(
                                                  _amount.text.trim()) ??
                                              0,
                                          note: _note.text,
                                        ));
                                  },
                            child: Text(
                              S.current.pay,
                              style: Theme.of(context).textTheme.button,
                            )),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _amount.clear();
                              _note.clear();
                            },
                            child: Text(
                              S.current.cancel,
                              style: Theme.of(context).textTheme.button,
                            ))
                      ],
                    );
                  });
                });
          },
        ),
        appBar: CustomC4dAppBar.appBar(context,
            title: S.current.orderLog,
            actions: [
              CustomC4dAppBar.actionIcon(context, onTap: () {
                ordersFilter.fromDate =
                    DateTime(today.year, today.month, today.day, 0)
                        .toIso8601String();
                ordersFilter.toDate = DateTime.now().toIso8601String();
                currentIndex = 0;
                getOrders();
              }, icon: Icons.restart_alt_rounded)
            ]),
        body: Column(
          children: [
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
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(-1, 0),
                              blurRadius: 6,
                              spreadRadius: 2.5,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3))
                        ],
                        color: Theme.of(context).colorScheme.primary,
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
                          title: Text(
                            S.current.firstDate,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            ordersFilter.fromDate != null
                                ? DateFormat('yyyy/M/d').format(DateTime.parse(
                                    ordersFilter.fromDate ??
                                        DateTime.now().toIso8601String()))
                                : '0000/00/00',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 32,
                      height: 2.5,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(-1, 0),
                              blurRadius: 6,
                              spreadRadius: 2.5,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3))
                        ],
                        color: Theme.of(context).colorScheme.primary,
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
                          title: Text(
                            S.current.endDate,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            ordersFilter.toDate != null
                                ? DateFormat('yyyy/M/d').format(DateTime.parse(
                                    ordersFilter.toDate ??
                                        DateTime.now().toIso8601String()))
                                : '0000/00/00',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
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
      ),
    );
  }
}
