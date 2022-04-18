import 'dart:async';
import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_bid_orders/request/order_filter_request.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/owner_orders.state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OwnerOrdersScreen extends StatefulWidget {
  final OwnerOrdersStateManager _stateManager;

  OwnerOrdersScreen(this._stateManager);

  @override
  OwnerOrdersScreenState createState() => OwnerOrdersScreenState();
}

class OwnerOrdersScreenState extends State<OwnerOrdersScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;
  StreamSubscription? _globalStateManager;


  Future<void> getMyOrdersFilter([loading = true]) async {
    widget._stateManager.getOrdersFilters(
        this, FilterBidOrderRequest(), loading);
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
    getMyOrdersFilter();
  }

  String? orderFilter;

  @override
  Widget build(BuildContext context) {
    return  Center(child: Container(child: _currentState.getUI(context)));
  }


  @override
  void dispose() {
    _stateSubscription?.cancel();
    _globalStateManager?.cancel();
    super.dispose();
  }

}
