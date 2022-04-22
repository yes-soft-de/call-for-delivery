import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_bid_orders/request/open_order_filter_request.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/open_orders.state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OpenOrdersScreen extends StatefulWidget {
  final OpenOrdersStateManager _stateManager;

  OpenOrdersScreen(this._stateManager);

  @override
  OpenOrdersScreenState createState() => OpenOrdersScreenState();
}

class OpenOrdersScreenState extends State<OpenOrdersScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;



 void getOpenOrdersFilters() async {
    widget._stateManager.getOpenOrdersFilters(
        this, FilterOpenBidOrderRequest());
  }

  bool featureFlag = true;
  @override
  void initState() {
    super.initState();
    _currentState = LoadingState(this);
    _stateSubscription = widget._stateManager.stateStream.listen((event) {
      _currentState = event;
      if (mounted) {
        setState(() {});
      }
    });
    getOpenOrdersFilters();
  }

  String? orderFilter;

  @override
  Widget build(BuildContext context) {
    return  Container(child: _currentState.getUI(context));
  }


  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

}
