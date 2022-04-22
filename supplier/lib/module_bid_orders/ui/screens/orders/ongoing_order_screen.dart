import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/request/bid_order_offer_filter_request.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/my_offer.state_manager.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/ongoing_order.state_manager.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/open_orders.state_manager.dart';
import 'package:c4d/module_bid_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OnGoingOrdersScreen extends StatefulWidget {
  final OnGoingOrderStateManager _stateManager;

  OnGoingOrdersScreen(this._stateManager);

  @override
  OnGoingOrdersScreenState createState() => OnGoingOrdersScreenState();
}

class OnGoingOrdersScreenState extends State<OnGoingOrdersScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;


  Future<void> getMyOrdersFilter([loading = true]) async {
    widget._stateManager.getOnGoingOrder(
        this, FilterOrderOfferRequest(openToPriceOffer: false,priceOfferStatus: 'confirmed'));
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

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(child: Container(child: _currentState.getUI(context))),
      ],
    );
  }


  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

}