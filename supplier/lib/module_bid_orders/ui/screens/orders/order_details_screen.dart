import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/request/add_offer_request.dart';
import 'package:c4d/module_bid_orders/request/confirm_offer_request.dart';
import 'package:c4d/module_bid_orders/state_manager/order_details_state_manager.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/open_orders.state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrderDetailsScreen extends StatefulWidget {
  final OrderDetailsStateManager _stateManager;

  OrderDetailsScreen(this._stateManager);

  @override
  OrderDetailsScreenState createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;

  AddOfferRequest? addOfferRequest;
   int orderId = -1;
   bool onGoing = false;


  var today = DateTime.now();
  late TextEditingController priceController;
  String? offerTime;

  void refresh(){
    if(mounted){
      setState(() {
      });
    }
  }

   void addOffer(){
     widget._stateManager.addNewOrder(this,AddOfferRequest(
       offerDeadline: offerTime,
       priceOfferValue: double.parse(priceController.text),
       bidOrder: orderId
     ));
   }
  void confirmOffer(ConfirmOfferRequest request){
    widget._stateManager.confirmOffer(this,request,orderId);
  }
  @override
  void initState() {
    super.initState();
    priceController =TextEditingController();
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
  var  args = ModalRoute.of(context)?.settings.arguments as Map;
    if (args != null && orderId == -1) {
        orderId = args['id'] as int;
        onGoing = args['onGoing'] as bool;
        if(onGoing)
          widget._stateManager.getOnGoingOrderDetails(this, orderId);

        else widget._stateManager.getOrderDetails(this, orderId);

    }
    return  Scaffold(
      appBar: CustomC4dAppBar.appBar(context, title:S.of(context).orderNumber+ ' '+orderId.toString()+'#',canGoBack: true),
        body: SafeArea(child: Container(child: _currentState.getUI(context))));
  }


  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }

}