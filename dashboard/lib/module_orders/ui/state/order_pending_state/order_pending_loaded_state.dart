import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/model/pending_order.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/ui/screens/order_pending_screen.dart';
import 'package:c4d/module_orders/ui/widgets/filter_bar.dart';
import 'package:c4d/module_orders/ui/widgets/owner_order_card/owner_order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:c4d/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders());
  }

  List<List<OrderModel>> ordersIndex = [];
  List<Widget> getOrders() {
    List<int> countsOrder = [
      orders.pendingOrdersCount,
      orders.notDeliveredOrdersCount,
      orders.hiddenOrdersCount,
    ];
    var context = screenState.context;
    List<Widget> widgets = [];
    widgets.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(
          FontAwesomeIcons.boxes,
          color: Theme.of(context).disabledColor,
        ),
        title: Text(
          S.current.countOrders +
              ' ${(Localizations.localeOf(context).languageCode == 'ar' ? 'ال' : '')}' +
              (screenState.currentIndex == 0
                  ? S.current.pending
                  : screenState.currentIndex == 1
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
    ));
    widgets.add(
      // filter on state
      FilterBar(
        cursorRadius: BorderRadius.circular(25),
        animationDuration: Duration(milliseconds: 350),
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: screenState.currentIndex,
        borderRadius: BorderRadius.circular(25),
        floating: true,
        height: 40,
        cursorColor: Theme.of(context).colorScheme.primary,
        items: [
          FilterItem(
            label: S.current.pending,
          ),
          FilterItem(label: S.current.notAccepted),
          FilterItem(label: S.current.hidden),
        ],
        onItemSelected: (index) {
          screenState.currentIndex = index;
          screenState.getOrders(false);
          screenState.refresh();
        },
        selectedContent: Theme.of(context).textTheme.button!.color!,
        unselectedContent: Theme.of(context).textTheme.headline6!.color!,
      ),
    );
    for (var element in ordersIndex[screenState.currentIndex]) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.of(screenState.context).pushNamed(
                  OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            },
            child: OwnerOrderCard(
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              orderCost: element.orderCost,
              note: element.note,
              orderIsMain: element.orderIsMain ?? false,
            ),
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
