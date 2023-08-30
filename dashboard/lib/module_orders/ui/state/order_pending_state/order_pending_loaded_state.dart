import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/model/pending_order.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/order_pending_screen.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/module_orders/ui/widgets/recycle_widgets/recycle_button_widget.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/extension/string_extensions.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_moment/simple_moment.dart';

class OrderPendingLoadedState extends States {
  OrderPendingScreenState screenState;
  PendingOrder orders;
  OrderPendingLoadedState(this.screenState, this.orders) : super(screenState) {
    ordersIndex = [
      orders.pendingOrders,
      orders.notDeliveredOrders,
      orders.hiddenOrders,
    ];
  }
  var moment = Moment.now();
  @override
  Widget getUI(BuildContext context) {
    List<int> countsOrder = [
      orders.pendingOrdersCount,
      orders.notDeliveredOrdersCount,
      orders.hiddenOrdersCount,
    ];
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(
                FontAwesomeIcons.boxesStacked,
                color: Theme.of(context).disabledColor,
              ),
              title: Text(
                S.current.countOrders +
                    ' ${(Localizations.localeOf(context).languageCode == 'ar' ? 'ال' : '')}' +
                    (screenState.currentIndex == 0
                        ? S.current.pending
                        : screenState.currentIndex == 2
                            ? S.current.hidden
                            : S.current.notAccepted),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              horizontalTitleGap: 4,
              trailing: Text(
                countsOrder[screenState.currentIndex].toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).disabledColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: AnimatedContainer(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: screenState.currentIndex != 0
                                ? Colors.grey
                                : Colors.white,
                            width: 1),
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(25),
                            bottomStart: Radius.circular(25)),
                        color: screenState.currentIndex == 0
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.background,
                      ),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          screenState.currentIndex = 0;
                          screenState.refresh();
                        },
                        child: Text(
                          S.current.pending,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: screenState.currentIndex != 0
                                ? Colors.black
                                : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: screenState.currentIndex != 1
                                  ? Colors.grey
                                  : Colors.white,
                              width: 1),
                          color: screenState.currentIndex == 1
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.background),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          screenState.currentIndex = 1;
                          screenState.refresh();
                        },
                        child: Text(
                          S.current.notAccepted,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: screenState.currentIndex != 1
                                ? Colors.black
                                : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                        ),
                      ),
                      // Text(S.current.hidden),
                    ),
                  ),
                  Expanded(
                    child: AnimatedContainer(
                      height: 40,
                      padding: EdgeInsets.all(8),
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: screenState.currentIndex != 2
                                  ? Colors.grey
                                  : Colors.white,
                              width: 1),
                          borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(25),
                              bottomEnd: Radius.circular(25)),
                          color: screenState.currentIndex == 2
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.background),
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          screenState.currentIndex = 2;
                          screenState.refresh();
                        },
                        child: Text(
                          S.current.hidden,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: screenState.currentIndex != 2
                                ? Colors.black
                                : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1,
                        ),
                      ),
                      // Text(S.current.hidden),
                    ),
                  ),
                ]),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: ordersIndex[screenState.currentIndex].length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var element = ordersIndex[screenState.currentIndex][index];
                if (screenState.isExternalFilterOn) {
                  if (element.externalCompanyName.nullOrEmpty()) {
                    return SizedBox();
                  }
                }
                return Padding(
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
                            orderIdInExternalCompany:
                                element.orderIdInExternalCompany,
                            externalCompanyName: element.externalCompanyName,
                            captainProfileId: element.captainProfileId,
                            isDelivered: screenState.currentIndex == 1,
                            orderNumber: element.id.toString(),
                            orderStatus: StatusHelper.getOrderStatusMessages(
                                element.state),
                            createdDate: moment.date
                                        .difference(element.created!)
                                        .inHours <=
                                    12
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
                                : StatusHelper.getOrderStatusColor(
                                    element.state),
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
                                                    OrdersRoutes
                                                        .RECYCLE_ORDERS_SCREEN,
                                                    (route) => false,
                                                    arguments: element.id,
                                                    // element.storeId
                                                  );
                                                },
                                                content: S.current
                                                    .recycleOrderWarning,
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<List<OrderModel>> ordersIndex = [];
}
