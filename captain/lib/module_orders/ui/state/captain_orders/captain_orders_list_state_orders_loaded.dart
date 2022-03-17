import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:simple_moment/simple_moment.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/accept_order.dart';
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
      appBar: CustomC4dAppBar.appBar(context,
          title: S.of(context).home, icon: Icons.sort_rounded, onTap: () {
        screenState.advancedController.showDrawer();
      }),
      body: Stack(
        children: [
          PageView(
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
          Align(alignment: Alignment.bottomCenter, child: _Footer(context))
        ],
      ),
    );
  }

  Widget _Footer(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.pinned,
      snakeShape: SnakeShape.indicator,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: const Radius.circular(10))),
      snakeViewColor: Theme.of(context).primaryColor,
      selectedItemColor: SnakeShape.indicator == SnakeShape.indicator
          ? Theme.of(context).primaryColor
          : null,
      unselectedItemColor: Theme.of(context).disabledColor,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.black
          : Colors.white,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      currentIndex: screenState.currentPage,
      onTap: (index) {
        screenState.currentPage = index;
        screenState.ordersPageController.animateToPage(screenState.currentPage,
            duration: const Duration(milliseconds: 750), curve: Curves.linear);
      },
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.directions_car),
            label: S.of(context).currentOrders),
        BottomNavigationBarItem(
            icon: const Icon(Icons.map_outlined),
            label: S.of(context).nearbyOrders),
      ],
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
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              note: element.note,
              orderCost: element.orderCost.toStringAsFixed(1),
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
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
    // List<OrderModel> orders =
    //     sortLocations(ordersData.data, ordersData.currentLocation);
    var now = DateTime.now();
    var moment = Moment.now();
    var uiList = <Widget>[];
    ordersData.data.forEach((element) {
      uiList.add(Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            Navigator.of(context).pushNamed(OrdersRoutes.ORDER_STATUS_SCREEN,
                arguments: element.id.toString());
          },
          child: OrderCard(
            createdDate: element.createdDate,
            deliveryDate: element.deliveryDate,
            note: element.note,
            orderCost: element.orderCost.toStringAsFixed(1),
            orderNumber: element.id.toString(),
            orderStatus: StatusHelper.getOrderStatusMessages(element.state),
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

  // List<OrderModel> sortLocations(List<OrderModel> order, var currentLocation) {
  //   if (currentLocation == null) {
  //     return order;
  //   }
  //   var sorted = order;
  //   sorted.sort((a, b) {
  //     try {
  //       double first = a.storeDistance ?? 0;
  //       double second = b.storeDistance ?? 0;
  //       return first.compareTo(second);
  //     } catch (e) {
  //       print(e.toString());
  //       return 1;
  //     }
  //   });
  //   return sorted;
  // }
}
