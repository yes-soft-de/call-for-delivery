import 'package:another_flushbar/flushbar.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/consts/order_status.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_orders/model/order/order_model.dart';
import 'package:c4d/module_orders/orders_routes.dart';
import 'package:c4d/module_orders/request/order_non_sub_request.dart';
import 'package:c4d/module_orders/request/update_order_request/update_order_request.dart';
import 'package:c4d/module_orders/ui/screens/sub_orders_screen.dart';
import 'package:c4d/module_orders/ui/widgets/home_widgets/order_card.dart';
import 'package:c4d/module_orders/ui/widgets/order_map_preview.dart';
import 'package:c4d/utils/components/custom_alert_dialog.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/components/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubOrdersListStateLoaded extends States {
  final List<OrderModel> orders;
  final bool acceptedOrder;
  final SubOrdersScreenState screenState;
  SubOrdersListStateLoaded(this.screenState,
      {required this.orders, required this.acceptedOrder})
      : super(screenState);
  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders());
  }

  List<Widget> getOrders() {
    var context = screenState.context;
    bool needToTakeAction = false;
    List<Widget> widgets = [];
    if (acceptedOrder == false) {
      widgets.add(Flushbar(
        icon: const Icon(
          FontAwesomeIcons.info,
          color: Colors.white,
        ),
        backgroundColor: Colors.amber,
        message: S.current.youNeedToAcceptPrimaryOrderFirst,
      ));
    }
    for (var element in orders) {
      widgets.add(Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            if (element.state == OrderStatusEnum.WAITING) {
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
                                      borderRadius: BorderRadius.circular(25),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor
                                          .withOpacity(0.95),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
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
                                                Icons.location_history_rounded,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              ),
                                            ),
                                          ),
                                        
                                            ],
                                          ),
                                          Visibility(
                                            visible:acceptedOrder || element.orderIsMain ,
                                            child: Spacer()),
                                          Visibility(
                                            visible: acceptedOrder || element.orderIsMain,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                var index = StatusHelper
                                                    .getOrderStatusIndex(
                                                        element.state);
                                                screenState.manager
                                                    .updateOrderState(
                                                  screenState,
                                                  UpdateOrderRequest(
                                                    id: element.id,
                                                    state: StatusHelper
                                                        .getStatusString(
                                                            OrderStatusEnum
                                                                    .values[
                                                                index + 1]),
                                                  ),
                                                );
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
            } else {
              Navigator.of(screenState.context).pushNamed(
                  OrdersRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            }
          },
          child: OrderCard(
            primaryTitle: element.orderIsMain
                ? S.current.primaryOrder
                : S.current.suborder,
            orderNumber: element.id.toString(),
            orderStatus: StatusHelper.getOrderStatusMessages(element.state),
            deliveryDate: element.deliveryDate,
            orderIsMain: element.orderIsMain,
            background: element.orderIsMain
                ? Colors.red[700]
                : StatusHelper.getOrderStatusColor(element.state),
            note: element.note,
            orderCost: FixedNumber.getFixedNumber(element.orderCost),
            destination: '',
            credit: element.paymentMethod != 'cash',
          ),
        ),
      ));
      if (widgets.length > 1 &&
          element.state == OrderStatusEnum.WAITING &&
          acceptedOrder) {
        needToTakeAction = true;
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Row(
            children: [
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    String? state;
                    if (orders[0].state == OrderStatusEnum.GOT_CAPTAIN) {
                      state = StatusHelper.getStatusString(
                          OrderStatusEnum.GOT_CAPTAIN);
                    } else {
                      state = StatusHelper.getStatusString(
                          OrderStatusEnum.DELIVERING);
                    }
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              onPressed: () {
                                Navigator.of(context).pop();
                                screenState.manager.updateOrderState(
                                    screenState,
                                    UpdateOrderRequest(
                                        id: element.id, state: state));
                              },
                              content: S.current.confirmAcceptSubOrder);
                        });
                  },
                  icon: const Icon(Icons.thumb_up_alt),
                  label: Text(S.current.accept)),
              const Spacer(),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              onPressed: () {
                                Navigator.of(context).pop();
                                screenState.manager.removeSubOrder(screenState,
                                    OrderNonSubRequest(orderID: element.id));
                              },
                              content: S.current.confirmRemoveSubOrder);
                        });
                  },
                  icon: const Icon(Icons.thumb_down_alt),
                  label: Text(S.current.reject))
            ],
          ),
        ));
      }
    }
    if (needToTakeAction) {
      widgets.insert(
          1,
          Flushbar(
            icon: const Icon(
              FontAwesomeIcons.info,
              color: Colors.white,
            ),
            backgroundColor: Colors.amber,
            message: S.current.thereIsSomeSubOrderNeedYouAttention,
          ));
    }
    widgets.add(const SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
