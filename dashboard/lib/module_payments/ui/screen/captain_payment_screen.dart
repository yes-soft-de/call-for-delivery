import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_captain/request/captain_daily_finance_request.dart';
import 'package:c4d/module_payments/state_manager/captain_payment_state_manager.dart';
import 'package:c4d/module_theme/pressistance/theme_preferences_helper.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@injectable
class CaptainPaymentScreen extends StatefulWidget {
  final CaptainPaymentStateManager _stateManager;

  const CaptainPaymentScreen(
    this._stateManager,
  );

  @override
  State<StatefulWidget> createState() => CaptainPaymentScreenState();
}

class CaptainPaymentScreenState extends State<CaptainPaymentScreen> {
  late StreamSubscription _streamSubscription;
  late States currentState;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  CaptainPaymentStateManager get manager => widget._stateManager;

  @override
  void initState() {
    currentState = LoadingState(this);
    paymentsFilter = CaptainDailyFinanceRequest();
    _streamSubscription = widget._stateManager.stateStream.listen((event) {
      currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  late CaptainDailyFinanceRequest paymentsFilter;
  int captainID = -1;
  String captainName = '';

  bool flag = true;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is List && flag) {
      captainID = args[0];
      captainName = args[1];
      flag = false;
      paymentsFilter.captainProfileId = captainID;
      widget._stateManager.getAccountBalance(this, paymentsFilter);
    }
    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: captainName + ' (${captainID})',
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
                              paymentsFilter.fromDate = value;
                              widget._stateManager
                                  .getAccountBalance(this, paymentsFilter);
                              setState(() {});
                            }
                          });
                        },
                        title: Text(S.current.firstDate),
                        subtitle: Text(paymentsFilter.fromDate != null
                            ? DateFormat('yyyy/M/d').format(
                                paymentsFilter.fromDate ?? DateTime.now())
                            : '0000/00/00'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 32,
                    height: 3,
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
                              paymentsFilter.toDate = value;
                              setState(() {});
                              widget._stateManager
                                  .getAccountBalance(this, paymentsFilter);
                            }
                          });
                        },
                        title: Text(S.current.endDate),
                        subtitle: Text(paymentsFilter.toDate != null
                            ? DateFormat('yyyy/M/d')
                                .format(paymentsFilter.toDate ?? DateTime.now())
                            : '0000/00/00'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 5, color: Theme.of(context).colorScheme.background),
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
