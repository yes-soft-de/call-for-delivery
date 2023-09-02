import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/external_order.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_orders_screen.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';

class ExternalOrdersLoadedState extends States {
  ExternalOrderScreenState screenState;
  ExternalOrder orders;

  ExternalOrdersLoadedState(this.screenState, this.orders)
      : super(screenState) {
    ordersIndex = [
      orders.pendingOrders,
      orders.notDeliveredOrders,
      orders.deliveredOrders,
    ];
  }
  List<List<OrderModel>> ordersIndex = [];
  var moment = Moment.now();
  @override
  Widget getUI(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Visibility(
            visible: ordersIndex[screenState.currentIndex].length != 0,
            replacement: SizedBox(
              height: 400,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(S.current.homeDataEmpty),
                    SizedBox(
                      height: 8,
                    ),
                    SvgPicture.asset(
                      SvgAsset.EMPTY_SVG,
                      width: 150,
                    )
                  ]),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: ordersIndex[screenState.currentIndex].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            if (ordersIndex[screenState.currentIndex][index]
                                .orderIsMain) {
                              Navigator.of(screenState.context).pushNamed(
                                  OrdersRoutes.SUB_ORDERS_SCREEN,
                                  arguments:
                                      ordersIndex[screenState.currentIndex]
                                              [index]
                                          .id);
                            } else {
                              Navigator.of(screenState.context).pushNamed(
                                  OrdersRoutes.ORDER_STATUS_SCREEN,
                                  arguments:
                                      ordersIndex[screenState.currentIndex]
                                              [index]
                                          .id);
                            }
                          },
                          child: OwnerOrderCard(
                            externalCompanyName:
                                ordersIndex[screenState.currentIndex][index]
                                    .externalCompanyName,
                            orderIdInExternalCompany:
                                ordersIndex[screenState.currentIndex][index]
                                    .orderIdInExternalCompany,
                            captainProfileId:
                                ordersIndex[screenState.currentIndex][index]
                                    .captainProfileId,
                            isDelivered: screenState.currentIndex == 1,
                            orderNumber: ordersIndex[screenState.currentIndex]
                                    [index]
                                .id
                                .toString(),
                            orderStatus: StatusHelper.getOrderStatusMessages(
                                ordersIndex[screenState.currentIndex][index]
                                    .state),
                            createdDate: moment.date
                                        .difference(ordersIndex[
                                                screenState.currentIndex][index]
                                            .created!)
                                        .inHours <=
                                    12
                                ? moment.from(
                                    ordersIndex[screenState.currentIndex][index]
                                        .created!)
                                : ordersIndex[screenState.currentIndex][index]
                                    .createdDate,
                            deliveryDate: screenState.currentIndex == 1
                                ? ordersIndex[screenState.currentIndex][index]
                                        .captainName ??
                                    S.current.unknown
                                : ordersIndex[screenState.currentIndex][index]
                                    .deliveryDate,
                            orderCost: ordersIndex[screenState.currentIndex]
                                    [index]
                                .orderCost,
                            note: ordersIndex[screenState.currentIndex][index]
                                .note,
                            orderIsMain: ordersIndex[screenState.currentIndex]
                                    [index]
                                .orderIsMain,
                            background: screenState.currentIndex == 0
                                ? (ordersIndex[screenState.currentIndex][index]
                                        .orderIsMain
                                    ? Colors.red[700]
                                    : null)
                                : StatusHelper.getOrderStatusColor(
                                    ordersIndex[screenState.currentIndex][index]
                                        .state),
                            branchName: ordersIndex[screenState.currentIndex]
                                    [index]
                                .branchName,
                            storeOwner: ordersIndex[screenState.currentIndex]
                                    [index]
                                .storeName,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
