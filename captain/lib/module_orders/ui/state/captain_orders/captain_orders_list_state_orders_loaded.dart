import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/widgets/home_widgets/order_card.dart';
import 'package:c4d/utils/components/custom_app_bar.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class CaptainOrdersListStateOrdersLoaded extends States {
  final DataModel myOrders;
  final DataModel nearbyOrders;
  final CaptainOrdersScreenState screenState;
  CaptainOrdersListStateOrdersLoaded(
      this.screenState, this.myOrders, this.nearbyOrders)
      : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: screenState.ordersPageController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        onPageChanged: (pos) {
          screenState.currentPage = pos;
          screenState.refresh();
        },
        children: [
          getMyOrdersList(context),
          getNearbyOrdersList(context),
        ],
      ),
    );
  }

  Widget getMyOrdersList(BuildContext context) {
    var uiList = <Widget>[];
    if (myOrders.hasError) {
      return ErrorStateWidget(
        error: myOrders.error,
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    } else if (myOrders.isEmpty) {
      return EmptyStateWidget(
        empty: S.current.homeDataEmpty,
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    } else {
      var acceptedOrders = myOrders as OrderModel;
      acceptedOrders.data.forEach((element) {
        uiList.add(Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id.toString());
            },
            child: OrderCard(
              deliveryDate: element.deliveryDate,
              note: element.note,
              orderCost: element.orderCost.toStringAsFixed(1),
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              destination: element.distance,
            ),
          ),
        ));
      });
      uiList.add(Container(
        height: 75,
      ));
      return RefreshIndicator(
          child: CustomListView.custom(children: uiList),
          onRefresh: () {
            return screenState.refreshOrders();
          });
    }
  }

  Widget getNearbyOrdersList(BuildContext context) {
    if (nearbyOrders.hasError) {
      return ErrorStateWidget(
        error: nearbyOrders.error,
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    }
    if (nearbyOrders.isEmpty) {
      return EmptyStateWidget(
        empty: S.current.homeDataEmpty,
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    }
    var ordersData = nearbyOrders as OrderModel;
    var now = DateTime.now();
    var moment = Moment.now();
    var uiList = <Widget>[];
    ordersData.data.forEach((element) {
      uiList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.of(context).pushNamed(OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id.toString());
            },
            child: NearbyOrdersCard(
              deliveryDate: element.deliveryDate,
              note: element.note,
              orderCost: element.orderCost.toStringAsFixed(1),
              orderNumber: element.id.toString(),
              branchName: element.branchName,
              distance: S.current.unknown == element.distance
                  ? element.distance
                  : S.current.distance +
                      ' ' +
                      element.distance +
                      ' ' +
                      S.current.km,
            ),
          ),
        ),
      ));
    });
    uiList.add(Container(
      height: 75,
    ));
    return RefreshIndicator(
        child: CustomListView.custom(children: uiList),
        onRefresh: () {
          return screenState.refreshOrders();
        });
  }
}
