import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_stores/model/order/order_captain_not_arrived.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/module_stores/ui/screen/order/order_captain_not_arrived.dart';
import 'package:c4d/module_stores/ui/widget/orders/order_captain_card.dart';
import 'package:flutter/material.dart';

class OrderCaptainLoadedState extends States {
  OrderCaptainNotArrivedScreenState screenState;
  List<OrderCaptainNotArrivedModel> orders;
  OrderCaptainLoadedState(this.screenState, this.orders) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var element = orders[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                Navigator.of(screenState.context).pushNamed(
                    StoresRoutes.ORDER_TIMELINE_SCREEN,
                    arguments: element.id);
              },
              child: CaptainNotCard(
                orderID: element.id,
                captainName: element.captainName,
                createdDate: element.createdDate,
                storeName: element.storeName,
                branchName: element.branchName,
              ),
            ),
          ),
        );
      },
    );
  }
}
