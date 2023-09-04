import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_payments/payments_routes.dart';
import 'package:c4d/module_stores/request/store_dues_request.dart';
import 'package:c4d/module_stores/state_manager/store_dues_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class StoreDuesScreen extends StatefulWidget {
  const StoreDuesScreen();

  @override
  State<StoreDuesScreen> createState() => StoreDuesScreenState();
}

class StoreDuesScreenState extends State<StoreDuesScreen> {
  late States _currentState;
  late StoreDuesStateManager _stateManager;
  late StreamSubscription _stateSubscription;

  late StoreDuesRequest filter;

  StoreDuesStateManager get stateManager => _stateManager;

  @override
  void initState() {
    _currentState = LoadingState(this);
    _stateManager = getIt();
    _stateSubscription = _stateManager.stateStream.listen((value) {
      _currentState = value;

      if (mounted) setState(() {});
    });

    filter = StoreDuesRequest(
        storeOwnerProfileId: 0, year: DateTime.now().year.toString());

    super.initState();
  }

  @override
  void dispose() {
    _stateSubscription.cancel();
    _stateManager.dispose();
    super.dispose();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void getStoresDues() {
    _stateManager.getStoreDues(this, filter);
  }

  String storeOwnerName = '';
  int storeOwnerId = -1;
  bool flag = true;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (flag && args != null && args is List) {
      storeOwnerId = args[0];
      storeOwnerName = args[1];
      flag = false;
      filter.storeOwnerProfileId = storeOwnerId;
      filter.isPaid = args[2];
      _stateManager.getStoreDues(this, filter);
    }

    return Scaffold(
      appBar: CustomC4dAppBar.appBar(context,
          title: storeOwnerName + ' (${storeOwnerId})',
          actions: [
            CustomC4dAppBar.actionIcon(context, onTap: () {
              Navigator.of(context).pushNamed(PaymentsRoutes.PAYMENTS_LIST,
                  arguments: storeOwnerId);
            }, icon: Icons.payments),
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
                      color: Theme.of(context).colorScheme.background,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(S.current.selectYear),
                                content: Container(
                                  width: 300,
                                  height: 300,
                                  child: YearPicker(
                                    firstDate:
                                        DateTime(DateTime.now().year - 100, 1),
                                    lastDate:
                                        DateTime(DateTime.now().year + 100, 1),
                                    initialDate: DateTime.now(),
                                    selectedDate: _selectedDate,
                                    onChanged: (DateTime dateTime) {
                                      _selectedDate = dateTime;
                                      Navigator.pop(context);
                                      filter.year = '${dateTime.year}';
                                      getStoresDues();
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${S.current.year}:'),
                              Text('${_selectedDate.year}'),
                              Icon(Icons.arrow_drop_down_circle_sharp),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 5, color: Theme.of(context).colorScheme.background),
          Expanded(child: _currentState.getUI(context)),
        ],
      ),
    );
  }
}
