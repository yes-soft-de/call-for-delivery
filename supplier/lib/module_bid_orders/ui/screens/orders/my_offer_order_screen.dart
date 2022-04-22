import 'dart:async';

import 'package:c4d/abstracts/states/loading_state.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_bid_orders/request/bid_order_offer_filter_request.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/my_offer.state_manager.dart';
import 'package:c4d/module_bid_orders/state_manager/owner_orders/open_orders.state_manager.dart';
import 'package:c4d/module_bid_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class OfferOrdersScreen extends StatefulWidget {
  final MyOffersStateManager _stateManager;

  OfferOrdersScreen(this._stateManager);

  @override
  OfferOrdersScreenState createState() => OfferOrdersScreenState();
}

class OfferOrdersScreenState extends State<OfferOrdersScreen> {
  late States _currentState;
  StreamSubscription? _stateSubscription;
  bool openToPriceOfferD = true;


  Future<void> getMyOrdersFilter([loading = true]) async {
    widget._stateManager.getMyOfferFilters(
        this, FilterOrderOfferRequest(openToPriceOffer: openToPriceOfferD,priceOfferStatus: orderFilter));
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

  String orderFilter='pending';
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        FilterBar(
          cursorRadius: BorderRadius.circular(25),
          animationDuration: Duration(milliseconds: 350),
          backgroundColor: Theme.of(context).backgroundColor,
          currentIndex: currentIndex,
          borderRadius: BorderRadius.circular(25),
          floating: true,
          height: 40,
          cursorColor: currentIndex == 0
              ? Theme.of(context).colorScheme.primary
              : StatusHelper.getOrderStatusColor(OrderStatusEnum.IN_STORE),
          items: [
            FilterItem(label: S.current.pendingOffer),
            FilterItem(label: S.current.acceptOffer),
            FilterItem(label: S.current.rejectOffer),
          ],
          onItemSelected: (index) {
            if (index == 0) {
              orderFilter = 'pending';
              openToPriceOfferD=true;
            } else  if (index == 1){
              orderFilter = 'accpeted';
              openToPriceOfferD=false;
            }
            else  if (index == 2){
              orderFilter = 'refused';
              openToPriceOfferD=true;
            }
            currentIndex = index;
            getMyOrdersFilter();
          },
          selectedContent: Theme.of(context).textTheme.button!.color!,
          unselectedContent: Theme.of(context).textTheme.headline6!.color!,
        ),
        SizedBox(
          height: 16,
        ),
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