import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/di/di_config.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/model/cars/cars_model.dart';
import 'package:c4d/module_bid_orders/request/add_offer_request.dart';
import 'package:c4d/module_bid_orders/state_manager/add_offer_state_manager.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/global/global_state_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddOfferScreen extends StatefulWidget {
  final AddOfferStateManager _stateManager;


  AddOfferScreen(this._stateManager);

  @override
  AddOfferScreenState createState() => AddOfferScreenState();
}

class AddOfferScreenState extends State<AddOfferScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;

  CarsModel? selectedCardModel;
  String? offerTime;

  void addOffer(String price ,String count) async {
    widget._stateManager.addNewOrder(this, AddOfferRequest(
      bidOrder: orderBidId,
      priceOfferValue:num.parse(price),
      offerDeadline: offerTime,
      deliveryCar: selectedCardModel?.id,
      transportationCount: num.parse(count)
    ));
  }
  void refresh(){
    if(mounted){
      setState(() {

      });
    }
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

    widget._stateManager.getDeliveryCars(this);
   }

  int orderBidId = -1;

  @override
  Widget build(BuildContext context) {
    var  args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && orderBidId == -1) {
      orderBidId = args as int;
    }
    return  Scaffold(
        appBar: CustomC4dAppBar.appBar(context, title:S.of(context).addYourOffer ,canGoBack: true),
        body: Container(child: _currentState.getUI(context)));
  }


  @override
  void dispose() {
    _stateSubscription?.cancel();
    super.dispose();
  }
}
