import 'package:c4d/abstracts/states/state.dart';
import 'package:c4d/generated/l10n.dart';
import 'package:c4d/module_stores/model/order/order_model.dart';
import 'package:c4d/module_stores/stores_routes.dart';
import 'package:c4d/module_stores/ui/screen/order/order_logs_screen.dart';
import 'package:c4d/module_stores/ui/widget/orders/owner_order_card.dart';
import 'package:c4d/utils/components/custom_feild.dart';
import 'package:c4d/utils/components/custom_list_view.dart';
import 'package:c4d/utils/helpers/fixed_numbers.dart';
import 'package:c4d/utils/helpers/order_status_helper.dart';
import 'package:flutter/material.dart';

class OrderLogsLoadedState extends States {
  OrderLogsScreenState screenState;
  List<OrderModel> orders;
  OrderLogsLoadedState(this.screenState, this.orders) : super(screenState);

  @override
  Widget getUI(BuildContext context) {
    return CustomListView.custom(children: getOrders());
  }

  List<Widget> getOrders() {
    var context = screenState.context;
    List<Widget> widgets = [];
    for (var element in orders) {
      widgets.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.of(screenState.context).pushNamed(
                  StoresRoutes.ORDER_STATUS_SCREEN,
                  arguments: element.id);
            },
            child: OwnerOrderCard(
              kilometer: element.kilometer > 0
                  ? FixedNumber.getFixedNumber(element.kilometer) +
                      ' ' +
                      S.current.km
                  : null,
              orderNumber: element.id.toString(),
              orderStatus: StatusHelper.getOrderStatusMessages(element.state),
              createdDate: element.createdDate,
              deliveryDate: element.deliveryDate,
              orderCost:
                  element.orderCost.toStringAsFixed(2) + ' ' + S.current.sar,
              note: element.note,
            ),
          ),
        ),
      ));
    }
    if (screenState.currentIndex == 2) {
      widgets.insert(
          0,
          Row(
            children: [
              Expanded(
                child: CustomFormField(
                  numbers: true,
                  hintStyle: TextStyle(fontSize: 10),
                  hintText: S.current.countKilometersTo +
                      '(${S.current.clientDistance})',
                  controller: screenState.geoController,
                  onChanged: () {
                    screenState.ordersFilter.maxKiloFromDistance =
                        num.tryParse(screenState.geoController.text) ?? -1;
                    screenState.getOrders(false);
                  },
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: CustomFormField(
                  numbers: true,
                  hintStyle: TextStyle(fontSize: 10),
                  hintText:
                      S.current.countKilometersTo + '(${S.current.captain})',
                  controller: screenState.captainController,
                  onChanged: () {
                    screenState.ordersFilter.maxKilo =
                        num.tryParse(screenState.captainController.text) ?? -1;
                    screenState.getOrders(false);
                  },
                ),
              ),
            ],
          ));
      widgets.insert(
          1,
          Center(
              child: Text(
            (widgets.length - 1).toString() + ' ' + S.current.sOrder,
            style: TextStyle(
              fontSize: 17,
            ),
          )));
    }
    widgets.add(SizedBox(
      height: 75,
    ));
    return widgets;
  }
}
