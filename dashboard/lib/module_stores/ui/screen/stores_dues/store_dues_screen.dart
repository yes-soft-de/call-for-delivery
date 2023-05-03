import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/request/store_dues_request.dart';
import 'package:c4d/module_stores/state_manager/store_dues_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoreDuesScreen extends StatefulWidget {
  final StoreDuesStateManager _manager;

  const StoreDuesScreen(this._manager, {Key? key}) : super(key: key);

  @override
  State<StoreDuesScreen> createState() => StoreDuesScreenState();
}

class StoreDuesScreenState extends State<StoreDuesScreen> {
  States? _currentState;

  late StoreDuesRequest filter;

  @override
  void initState() {
    _currentState = LoadingState(this);
    widget._manager.stateStream.listen((value) {
      _currentState = value;

      if (mounted) setState(() {});
    });

    filter = StoreDuesRequest(
        StoreOwnerProfileId: 0, fromDate: '', isPaid: '', toDate: '');

    widget._manager.getStoreDues(this, filter);
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

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (flag && args != null && args is List) {
      storeOwnerId = args[0];
      storeOwnerName = args[1];
      flag = false;
      filter.StoreOwnerProfileId = storeOwnerId;
      widget._manager.getStoreDues(this, filter);
    }

    return const Placeholder();
  }
}
