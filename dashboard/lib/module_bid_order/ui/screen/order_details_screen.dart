import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_order/state_manager/bid_order_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class BidOrderDetailsScreen extends StatefulWidget {
  final BidOrderStateManager _stateManager;

  BidOrderDetailsScreen(this._stateManager);

  @override
  BidOrderDetailsScreenState createState() => BidOrderDetailsScreenState();
}

class BidOrderDetailsScreenState extends State<BidOrderDetailsScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;
  late StreamSubscription _globalStreamSubscription;
  int orderId = -1;
  bool onGoing = false;

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }

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
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && orderId == -1) {
//        orderId = args as int;
//        if(onGoing)
//          widget._stateManager.getOnGoingOrderDetails(this, orderId);
//
//        else widget._stateManager.getBidOrder(this, orderId);
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(context,
            title: S.of(context).orderNumber + ' ' + orderId.toString() + '#',
            canGoBack: true),
        body: SafeArea(child: Container(child: _currentState.getUI(context))));
  }

  @override
  void dispose() {
    _globalStreamSubscription.cancel();
    _stateSubscription?.cancel();
    super.dispose();
  }
}
