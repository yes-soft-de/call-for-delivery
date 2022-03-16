import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';

class OrderCard extends StatelessWidget {
  final String orderId;
  final OrderStatusEnum? orderStatus;
  final String orderDate;
  final double? orderDestination;
  final int? orderType;
  final String? storeName;
  final String? branchName;
  final bool acceptedOrder;
  OrderCard(
      {required this.orderId,
      this.orderStatus,
      required this.orderDate,
      this.orderDestination,
      required this.orderType,
      this.branchName,
      this.storeName,
      this.acceptedOrder = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, OrdersRoutes.ORDER_STATUS_SCREEN,
              arguments: orderId);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor.withOpacity(0.7),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                // order number and order date
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Text(S.of(context).orderNumber,
                            style: TextStyle(fontSize: 14)),
                        Container(
                          height: 4,
                        ),
                        Text(
                          '$orderId',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor),
                        ),
                      ],
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Flex(
                      direction: Axis.vertical,
                      children: [
                        Text(S.of(context).orderDate,
                            style: TextStyle(fontSize: 14)),
                        Container(
                          height: 4,
                        ),
                        Text(
                          orderDate,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).disabledColor),
                        )
                      ],
                    ),
                  ],
                ),
                // divider
                orderType != null
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Divider(
                          color: Colors.grey[400]?.withOpacity(0.3),
                          thickness: 2,
                        ),
                      )
                    : Container(),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      S.of(context).orderType,
                      style: TextStyle(),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      getOrderType(orderType ?? 0),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).disabledColor),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                  child: Divider(
                    color: Colors.grey[400]?.withOpacity(0.3),
                    thickness: 2,
                  ),
                ),
                orderStatus != null && acceptedOrder
                    ? Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).orderStatus,
                              style: TextStyle(fontSize: 14)),
                          Padding(
                            padding:
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? EdgeInsets.only(left: 20.0)
                                    : EdgeInsets.only(right: 20.0),
                            child: Text(
                              StatusHelper.getOrderStatusMessages(orderStatus),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).disabledColor),
                            ),
                          ),
                          FaIcon(
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? FontAwesomeIcons.arrowCircleLeft
                                : FontAwesomeIcons.arrowCircleRight,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      )
                    : Flex(
                        direction: Axis.horizontal,
                        children: [
                          Spacer(
                            flex: 2,
                          ),
                          FaIcon(
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? FontAwesomeIcons.arrowCircleLeft
                                : FontAwesomeIcons.arrowCircleRight,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getOrderType(int orderType) {
    switch (orderType) {
      case 1:
        return S.current.products;
      case 2:
        return S.current.privateOrder;
      case 3:
        return S.current.deliverForMe;
      default:
        return S.current.unknown;
    }
  }
}
