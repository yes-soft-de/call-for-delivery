import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_profile/request/captain_payments_request.dart';
import 'package:c4d/module_profile/state_manager/account_balance_state_manager.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class AccountBalanceScreen extends StatefulWidget {
  final AccountBalanceStateManager _stateManager;

  const AccountBalanceScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => AccountBalanceScreenState();
}

class AccountBalanceScreenState extends State<AccountBalanceScreen> {
  late StreamSubscription _streamSubscription;
  late States currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  var today = DateTime.now();
  @override
  void initState() {
    currentState = LoadingState(this);
    paymentsFilter = CaptainPaymentRequest(
        fromDate:
            DateTime(today.year, today.month, today.day, 0).toIso8601String(),
        toDate: DateTime.now().toIso8601String());
    widget._stateManager.getAccountBalance(this, paymentsFilter);
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  late CaptainPaymentRequest paymentsFilter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: S.current.payments,
      ),
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
                              paymentsFilter.fromDate = value.toIso8601String();
                              widget._stateManager
                                  .getAccountBalance(this, paymentsFilter);
                              setState(() {});
                            }
                          });
                        },
                        title: Text(S.current.firstDate),
                        subtitle: Text(paymentsFilter.fromDate != null
                            ? DateFormat('yyyy/M/d').format(DateTime.parse(
                                paymentsFilter.fromDate ??
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
                              paymentsFilter.toDate = value.toIso8601String();
                              setState(() {});
                              widget._stateManager
                                  .getAccountBalance(this, paymentsFilter);
                            }
                          });
                        },
                        title: Text(S.current.endDate),
                        subtitle: Text(paymentsFilter.toDate != null
                            ? DateFormat('yyyy/M/d').format(DateTime.parse(
                                paymentsFilter.toDate ??
                                    DateTime.now().toIso8601String()))
                            : '0000/00/00'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(child: currentState.getUI(context)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
