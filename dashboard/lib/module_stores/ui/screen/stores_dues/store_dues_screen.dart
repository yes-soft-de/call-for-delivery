import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/request/store_dues_request.dart';
import 'package:c4d/module_stores/state_manager/store_dues_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreDuesScreen extends StatefulWidget {
  final StoreDuesStateManager _manager;

  const StoreDuesScreen(this._manager);

  @override
  State<StoreDuesScreen> createState() => StoreDuesScreenState();
}

class StoreDuesScreenState extends State<StoreDuesScreen> {
  States? _currentState;

  late StoreDuesRequest filter;

  StoreDuesStateManager get stateManager => widget._manager;

  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateStream.listen((value) {
      _currentState = value;

      if (mounted) setState(() {});
    });

    filter = StoreDuesRequest(storeOwnerProfileId: 0);

    super.initState();
  }

  void refresh() {
    if (mounted) setState(() {});
  }

  void getStoresDues() {
    widget._manager.getStoreDues(this, filter);
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
      widget._manager.getStoreDues(this, filter);
    }

    return Scaffold(
      appBar: CustomC4dAppBar.appBar(
        context,
        title: storeOwnerName + ' (${storeOwnerId})',
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
                      child: TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(S.current.selectYear),
                                content: Container(
                                  // Need to use container to add size constraint.
                                  width: 300,
                                  height: 300,
                                  child: YearPicker(
                                    firstDate:
                                        DateTime(DateTime.now().year - 100, 1),
                                    lastDate:
                                        DateTime(DateTime.now().year + 100, 1),
                                    initialDate: DateTime.now(),
                                    // save the selected date to _selectedDate DateTime variable.
                                    // It's used to set the previous selected date when
                                    // re-showing the dialog.
                                    selectedDate: _selectedDate,
                                    onChanged: (DateTime dateTime) {
                                      // close the dialog when year is selected.
                                      _selectedDate = dateTime;
                                      Navigator.pop(context);
                                      filter.year = '${dateTime.year}';
                                      getStoresDues();
                                      // Do something with the dateTime selected.
                                      // Remember that you need to use dateTime.year to get the year
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
          Expanded(child: _currentState!.getUI(context)),
        ],
      ),
    );
  }
}
