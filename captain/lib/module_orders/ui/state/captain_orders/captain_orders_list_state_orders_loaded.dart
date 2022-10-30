import 'package:c4d/abstracts/data_model/data_model.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/ui/widgets/geo_widget.dart';
import 'package:c4d/module_orders/ui/widgets/order_map_preview.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/ui/screens/captain_orders/captain_orders.dart';
import 'package:c4d/module_orders/ui/widgets/home_widgets/order_card.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/empty_screen.dart';
import 'package:c4d/utils/components/error_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:bottom_sheet/bottom_sheet.dart';

class CaptainOrdersListStateOrdersLoaded extends States {
  final DataModel myOrders;
  final DataModel nearbyOrders;
  final CaptainOrdersScreenState screenState;
  CaptainOrdersListStateOrdersLoaded(
      this.screenState, this.myOrders, this.nearbyOrders)
      : super(screenState) {
    sortedList = false;
  }
  final TextEditingController searchNearby = TextEditingController();
  final TextEditingController searchAccepted = TextEditingController();
  bool sortedList = false;
  @override
  Widget getUI(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var focus = FocusScope.of(context);
        if (focus.canRequestFocus) {
          focus.unfocus();
        }
      },
      child: Scaffold(
        body: Visibility(
          replacement: getNearbyOrdersList(context),
          visible: screenState.currentPage == 0,
          child: getMyOrdersList(context),
        ),
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
      return MyOrdersStateWidget(
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    } else {
      uiList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomFormField(
            onChanged: (s) {
              screenState.refresh();
            },
            numbers: true,
            hintText: S.current.searchForOrder,
            preIcon: const Icon(Icons.search_rounded),
            controller: searchAccepted),
      ));
      var acceptedOrders = myOrders as OrderModel;
      for (var element in acceptedOrders.data) {
        if (searchAccepted.text != '' &&
            element.id.toString().contains(searchAccepted.text) == false) {
          continue;
        }
        uiList.add(Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              if (element.orderIsMain && element.subOrders.isNotEmpty) {
                Navigator.of(context).pushNamed(OrdersRoutes.SUB_ORDERS_SCREEN,
                    arguments: element.id);
              } else {
                Navigator.of(context).pushNamed(
                    OrdersRoutes.ORDER_STATUS_SCREEN,
                    arguments: element.id.toString());
              }
            },
            child: OrderCard(
              orderIsMain: element.orderIsMain,
              background: element.orderIsMain
                  ? Colors.red[700]
                  : StatusHelper.getOrderStatusColor(element.state),
              deliveryDate: element.deliveryDate,
              note: element.note,
              orderCost: FixedNumber.getFixedNumber(element.orderCost),
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              destination: '',
              credit: element.paymentMethod != 'cash',
            ),
          ),
        ));
      }
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
      return ErrorOrderNotificationStateWidget(
        error: nearbyOrders.error,
        onRefresh: () {
          screenState.changeStatus(true);
          screenState.getMyOrders();
        },
      );
    }
    if (nearbyOrders.isEmpty) {
      return NearbyOrdersEmptyStateWidget(
        onRefresh: () {
          screenState.getMyOrders();
        },
      );
    }
    var ordersData = nearbyOrders as OrderModel;
    var uiList = <Widget>[];
    var data = screenState.currentLocation != null
        ? _sortOrder(ordersData.data)
        : ordersData.data;
    List<Widget> farOrders = [];
    for (var element in data) {
      if (searchNearby.text != '' &&
          element.id.toString().contains(searchNearby.text) == false) {
        continue;
      }
      if (element.distance.toDouble() > 9.9) {
        farOrders.add(Padding(
          key: ValueKey(element.id),
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                if (element.orderIsMain && element.subOrders.isNotEmpty) {
                  Navigator.of(context).pushNamed(
                      OrdersRoutes.SUB_ORDERS_SCREEN,
                      arguments: element.id);
                } else {
                  showFlexibleBottomSheet(
                      barrierColor: Colors.transparent,
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(25))),
                      builder: (BuildContext context,
                          ScrollController scrollController,
                          double bottomSheetOffset) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                width: 50,
                                height: 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Theme.of(context).backgroundColor),
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  OrderMapPreview(
                                    order: element,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor
                                              .withOpacity(0.95),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                      width: 6),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.store_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(4),
                                                width: 16,
                                                height: 2.5,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                              ),
                                              Text(
                                                (element.storeBranchToClientDistance
                                                            ?.toString() ??
                                                        S.current.unknown) +
                                                    (element.storeBranchToClientDistance ==
                                                            null
                                                        ? ''
                                                        : ' ${S.current.km}'),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.all(4),
                                                width: 16,
                                                height: 2.5,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primaryContainer,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                      width: 6),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons
                                                        .location_history_rounded,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              ElevatedButton.icon(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  var index = StatusHelper
                                                      .getOrderStatusIndex(
                                                          element.state);
                                                  screenState.stateManager
                                                      .updateOrder(
                                                          UpdateOrderRequest(
                                                            id: element.id,
                                                            state: StatusHelper
                                                                .getStatusString(
                                                                    OrderStatusEnum
                                                                            .values[
                                                                        index +
                                                                            1]),
                                                          ),
                                                          screenState);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        const StadiumBorder()),
                                                label: Text(
                                                  S.current.accept,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button,
                                                ),
                                                icon: const Icon(
                                                  Icons.thumb_up_alt_rounded,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      context: context);
                }
              },
              child: NearbyOrdersCard(
                acceptOrder: () {
                  var index = StatusHelper.getOrderStatusIndex(element.state);
                  screenState.stateManager.updateOrder(
                      UpdateOrderRequest(
                        id: element.id,
                        state: StatusHelper.getStatusString(
                            OrderStatusEnum.values[index + 1]),
                      ),
                      screenState);
                },
                background: element.orderIsMain
                    ? Colors.red[700]
                    : Theme.of(context).colorScheme.secondary,
                orderIsMain: element.orderIsMain,
                note: element.note,
                orderCost: FixedNumber.getFixedNumber(element.orderCost),
                orderNumber: element.id.toString(),
                branchName: element.branchName,
                branchToDestination: element.storeBranchToClientDistance != null
                    ? FixedNumber.getFixedNumber(
                        element.storeBranchToClientDistance ?? 0)
                    : null,
                distance: Visibility(
                  visible: screenState.currentLocation != null,
                  child: GeoDistanceText(
                    destance: (s) {
                      s?.replaceAll(',', '');
                      if (num.tryParse(s ?? '') != null) {
                        element.distance = num.tryParse(s ?? '') ?? 0;
                        screenState.refresh();
                      }
                    },
                    destination: element.location ?? LatLng(0, 0),
                    origin: screenState.currentLocation ?? LatLng(0, 0),
                    textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                credit: element.paymentMethod != 'cash',
                storeName: element.storeName,
              ),
            ),
          ),
        ));
        continue;
      }
      uiList.add(Padding(
        key: ValueKey(element.id),
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              if (element.orderIsMain && element.subOrders.isNotEmpty) {
                Navigator.of(context).pushNamed(OrdersRoutes.SUB_ORDERS_SCREEN,
                    arguments: element.id);
              } else {
                showFlexibleBottomSheet(
                    bottomSheetColor: Colors.transparent,
                    barrierColor: Colors.transparent,
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25))),
                    builder: (BuildContext context,
                        ScrollController scrollController,
                        double bottomSheetOffset) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              width: 50,
                              height: 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Theme.of(context).backgroundColor),
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                OrderMapPreview(
                                  order: element,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .withOpacity(0.95),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                    width: 6),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons.store_rounded,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(4),
                                              width: 16,
                                              height: 2.5,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            Text(
                                              (element.storeBranchToClientDistance
                                                          ?.toString() ??
                                                      S.current.unknown) +
                                                  ' ' +
                                                  (element.storeBranchToClientDistance ==
                                                          null
                                                      ? ''
                                                      : S.current.km),
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.all(4),
                                              width: 16,
                                              height: 2.5,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                    width: 6),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Icon(
                                                  Icons
                                                      .location_history_rounded,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                var index = StatusHelper
                                                    .getOrderStatusIndex(
                                                        element.state);
                                                screenState.stateManager
                                                    .updateOrder(
                                                        UpdateOrderRequest(
                                                          id: element.id,
                                                          state: StatusHelper
                                                              .getStatusString(
                                                                  OrderStatusEnum
                                                                          .values[
                                                                      index +
                                                                          1]),
                                                        ),
                                                        screenState);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: const StadiumBorder()),
                                              label: Text(
                                                S.current.accept,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                              icon: const Icon(
                                                Icons.thumb_up_alt_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    context: context);
              }
            },
            child: NearbyOrdersCard(
              background: element.orderIsMain ? Colors.red[700] : null,
              orderIsMain: element.orderIsMain,
              note: element.note,
              orderCost: FixedNumber.getFixedNumber(element.orderCost),
              orderNumber: element.id.toString(),
              branchName: element.branchName,
              branchToDestination: element.storeBranchToClientDistance != null
                  ? FixedNumber.getFixedNumber(
                      element.storeBranchToClientDistance ?? 0)
                  : null,
              distance: Visibility(
                visible: screenState.currentLocation != null,
                child: GeoDistanceText(
                  destance: (s) {
                    s = s?.replaceAll(',', '');
                    if (num.tryParse(s ?? '') != null) {
                      element.distance = num.tryParse(s ?? '') ?? 0;
                      screenState.refresh();
                    }
                  },
                  destination: element.location ?? LatLng(0, 0),
                  origin: screenState.currentLocation ?? LatLng(0, 0),
                  textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              credit: element.paymentMethod != 'cash',
              storeName: element.storeName,
              acceptOrder: () {
                var index = StatusHelper.getOrderStatusIndex(element.state);
                screenState.stateManager.updateOrder(
                    UpdateOrderRequest(
                      id: element.id,
                      state: StatusHelper.getStatusString(
                          OrderStatusEnum.values[index + 1]),
                    ),
                    screenState);
              },
            ),
          ),
        ),
      ));
    }
    if (farOrders.isNotEmpty) {
      uiList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(18),
          ),
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.info,
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            title: Text(
              S.current.thereIsFarawayOrder,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
      if (screenState.farOrders) {
        uiList.addAll(farOrders);
      }
    }
    uiList.add(Container(
      height: 75,
    ));
    return RefreshIndicator(
        child: CustomListView.custom(children: uiList),
        onRefresh: () {
          return screenState.refreshOrders();
        });
  }

  List<OrderModel> _sortOrder(List<OrderModel> orders) {
    if (orders.isEmpty) {
      return [];
    } else {
      List<OrderModel> sorted = orders;
      sorted.sort((a, b) {
        try {
          var pos1 = a.distance;
          var pos2 = b.distance;
          return pos2.compareTo(pos1);
        } catch (e) {
          return 1;
        }
      });
      return sorted;
    }
  }
}
