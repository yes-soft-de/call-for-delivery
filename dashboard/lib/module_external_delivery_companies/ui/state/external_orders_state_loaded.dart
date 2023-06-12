import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_external_delivery_companies/model/external_order.dart';
import 'package:c4d/module_external_delivery_companies/ui/screen/external_orders_screen.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/module_orders/ui/widgets/recycle_widgets/recycle_button_widget.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_moment/simple_moment.dart';

class ExternalOrdersLoadedState extends States {
  ExternalOrderScreenState screenState;
  ExternalOrder orders;

  ExternalOrdersLoadedState(this.screenState, this.orders)
      : super(screenState) {
    ordersIndex = [
      orders.pendingOrders,
      orders.notDeliveredOrders,
      orders.hiddenOrders,
    ];
  }
  var moment = Moment.now();
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders(context));
  }

  List<List<OrderModel>> ordersIndex = [];
  List<Widget> getOrders(context) {
    List<Widget> widgets = [];

    for (var element in ordersIndex[screenState.currentIndex]) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  if (element.orderIsMain) {
                    Navigator.of(screenState.context).pushNamed(
                        OrdersRoutes.SUB_ORDERS_SCREEN,
                        arguments: element.id);
                  } else {
                    Navigator.of(screenState.context).pushNamed(
                        OrdersRoutes.ORDER_STATUS_SCREEN,
                        arguments: element.id);
                  }
                },
                child: OwnerOrderCard(
                  captainProfileId: element.captainProfileId,
                  isDelivered: screenState.currentIndex == 1,
                  orderNumber: element.id.toString(),
                  orderStatus:
                      StatusHelper.getOrderStatusMessages(element.state),
                  createdDate:
                      moment.date.difference(element.created!).inHours <= 12
                          ? moment.from(element.created!)
                          : element.createdDate,
                  deliveryDate: screenState.currentIndex == 1
                      ? element.captainName ?? S.current.unknown
                      : element.deliveryDate,
                  orderCost: element.orderCost,
                  note: element.note,
                  orderIsMain: element.orderIsMain,
                  background: screenState.currentIndex == 0
                      ? (element.orderIsMain ? Colors.red[700] : null)
                      : StatusHelper.getOrderStatusColor(element.state),
                  branchName: element.branchName,
                  storeOwner: element.storeName,
                ),
              ),
              screenState.currentIndex == 2
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        child: RecycleOrderButton(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (ctx) {
                                  return CustomAlertDialog(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          OrdersRoutes.RECYCLE_ORDERS_SCREEN,
                                          (route) => false,
                                          arguments: element.id,
                                          // element.storeId
                                        );
                                      },
                                      content: S.current.recycleOrderWarning,
                                      oneAction: false);
                                });
                          },
                          backgroundColor: Colors.green,
                          icon: FontAwesomeIcons.recycle,
                          title: S.current.recycleOrder,
                          short: true,
                        ),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ));
    }
    if (widgets.length == 1) {
      widgets.add(SizedBox(
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
      ));
    }
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
