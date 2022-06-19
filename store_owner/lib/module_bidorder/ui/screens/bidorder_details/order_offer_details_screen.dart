import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bidorder/request/offer_state_request.dart';
import '../../../state_manager/bidorder_details/order_offer_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderOfferDetailsScreen extends StatefulWidget {
  final OrderOffersDetailsStateManager _stateManager;

  OrderOfferDetailsScreen(this._stateManager);

  @override
  OrderOfferDetailsScreenState createState() => OrderOfferDetailsScreenState();
}

class OrderOfferDetailsScreenState extends State<OrderOfferDetailsScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;

  void updateOfferState(OfferStateRequest request) {
    request.bidOrderId = bidOrderId;
    widget._stateManager.updateOfferState(this, request);
  }

  int bidOrderId = -1;

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
    if (args != null && bidOrderId == -1) {
      bidOrderId = args as int;
      widget._stateManager.getOrderOffers(this, bidOrderId);
    }
    return Scaffold(
        appBar: CustomC4dAppBar.appBar(context, title: S.current.orderOffers),
        body: SafeArea(child: _currentState.getUI(context)));
  }
}
